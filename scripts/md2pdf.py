#!/usr/bin/env python3
"""마크다운 → 한글 PDF 변환.

사용: python3 scripts/md2pdf.py <입력.md> <출력.pdf> [제목]

macOS 내장 한글 폰트(AppleGothic)를 써서 별도 설치 없이 한글이 정상 출력된다.
지원: # ~ ###, 표, 목록(-, 1.), 인용(>), 굵게(**), 수평선(---), 빈 줄
"""
import re
import sys
from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import cm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import (
    HRFlowable, PageBreak, Paragraph, SimpleDocTemplate, Spacer, Table, TableStyle,
)

FONT_CANDIDATES = [
    "/System/Library/Fonts/Supplemental/AppleGothic.ttf",
    "/Library/Fonts/NanumGothic.ttf",
    "/System/Library/Fonts/Supplemental/AppleMyungjo.ttf",
]


def register_font() -> str:
    for path in FONT_CANDIDATES:
        if Path(path).exists():
            pdfmetrics.registerFont(TTFont("KR", path))
            return "KR"
    raise SystemExit(
        "한글 폰트를 찾지 못했습니다. 확인한 경로:\n  " + "\n  ".join(FONT_CANDIDATES)
    )


def make_styles(font: str) -> dict:
    base = getSampleStyleSheet()["Normal"]
    mk = lambda **kw: ParagraphStyle(parent=base, fontName=font, **kw)
    return {
        "title": mk(name="t", fontSize=20, leading=28, spaceAfter=6, alignment=TA_CENTER),
        "subtitle": mk(name="st", fontSize=10, leading=14, textColor=colors.grey,
                       alignment=TA_CENTER, spaceAfter=18),
        "h1": mk(name="h1", fontSize=16, leading=22, spaceBefore=16, spaceAfter=8),
        "h2": mk(name="h2", fontSize=13, leading=19, spaceBefore=12, spaceAfter=6),
        "h3": mk(name="h3", fontSize=11.5, leading=17, spaceBefore=10, spaceAfter=4),
        "body": mk(name="b", fontSize=10.5, leading=17, spaceAfter=5),
        "bullet": mk(name="li", fontSize=10.5, leading=17, leftIndent=14,
                     bulletIndent=4, spaceAfter=3),
        "quote": mk(name="q", fontSize=10.5, leading=17, leftIndent=16,
                    textColor=colors.HexColor("#444444"), spaceBefore=4, spaceAfter=6),
        "cell": mk(name="c", fontSize=9, leading=13),
    }


# 한글 폰트(AppleGothic)에 없는 이모지는 네모(■)로 깨진다.
# 폰트가 가진 기호나 글자로 바꿔준다. 여기 없는 이모지를 쓰면 깨지니 필요하면 추가할 것.
EMOJI_MAP = {
    "⚠️": "※", "⚠": "※",
    "✅": "[O]", "❌": "[X]", "⬜": "[ ]", "🔲": "[ ]",
    "⭐": "★", "🌟": "★",
    "📌": "·", "📁": "·", "📚": "·", "📝": "·", "📧": "·", "📊": "·",
    "🏛️": "", "🏠": "", "⛪": "", "🌏": "", "🧪": "", "🔗": "",
    "🔴": "[!]", "🟡": "[~]", "🟢": "[O]", "🔵": "●", "🟣": "●",
    "🟠": "●", "🟤": "●", "💡": "·", "🕳️": "·", "⚔️": "·", "🏷": "·",
}


def strip_emoji(text: str) -> str:
    for k, v in EMOJI_MAP.items():
        text = text.replace(k, v)
    return text


def inline(text: str) -> str:
    """마크다운 인라인 서식 → reportlab 마크업. 이스케이프를 먼저 한다."""
    text = strip_emoji(text)
    text = text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    text = re.sub(r"\*\*(.+?)\*\*", r"<b>\1</b>", text)
    text = re.sub(r"(?<!\*)\*([^*]+?)\*(?!\*)", r"<i>\1</i>", text)
    # 인라인 코드: Courier로 바꾸면 한글이 전부 깨진다(글리프 없음).
    # 한글 폰트를 유지한 채 색으로만 구분한다.
    text = re.sub(r"`(.+?)`", r"<font color='#B03030'>\1</font>", text)
    text = re.sub(r"\[(.+?)\]\((.+?)\)", r"\1", text)  # 링크는 텍스트만
    return text


def split_row(line: str) -> list:
    return [c.strip() for c in line.strip().strip("|").split("|")]


def build(md: str, styles: dict, font: str) -> list:
    flow, lines, i = [], md.splitlines(), 0
    while i < len(lines):
        raw = lines[i]
        line = raw.rstrip()

        if not line.strip():
            flow.append(Spacer(1, 5)); i += 1; continue

        # 표: 헤더 + 구분선 + 본문
        if line.lstrip().startswith("|") and i + 1 < len(lines) and \
                re.match(r"^\s*\|[\s:|-]+\|\s*$", lines[i + 1]):
            header = split_row(line)
            i += 2
            rows = []
            while i < len(lines) and lines[i].lstrip().startswith("|"):
                rows.append(split_row(lines[i])); i += 1
            data = [[Paragraph(inline(c), styles["cell"]) for c in header]]
            for r in rows:
                r += [""] * (len(header) - len(r))
                data.append([Paragraph(inline(c), styles["cell"]) for c in r[:len(header)]])
            t = Table(data, repeatRows=1, hAlign="LEFT")
            t.setStyle(TableStyle([
                ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#EFEFEF")),
                ("GRID", (0, 0), (-1, -1), 0.4, colors.HexColor("#BBBBBB")),
                ("VALIGN", (0, 0), (-1, -1), "TOP"),
                ("LEFTPADDING", (0, 0), (-1, -1), 5),
                ("RIGHTPADDING", (0, 0), (-1, -1), 5),
                ("TOPPADDING", (0, 0), (-1, -1), 4),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 4),
            ]))
            flow.extend([t, Spacer(1, 10)])
            continue

        if re.match(r"^\s*(---+|\*\*\*+|___+)\s*$", line):
            flow.append(HRFlowable(width="100%", thickness=0.6,
                                   color=colors.HexColor("#CCCCCC"),
                                   spaceBefore=8, spaceAfter=8))
            i += 1; continue

        if line.startswith("### "):
            flow.append(Paragraph(inline(line[4:]), styles["h3"]))
        elif line.startswith("## "):
            flow.append(Paragraph(inline(line[3:]), styles["h2"]))
        elif line.startswith("# "):
            flow.append(Paragraph(inline(line[2:]), styles["h1"]))
        elif line.lstrip().startswith(">"):
            flow.append(Paragraph(inline(line.lstrip()[1:].strip()), styles["quote"]))
        elif re.match(r"^\s*[-*+]\s+", line):
            flow.append(Paragraph(inline(re.sub(r"^\s*[-*+]\s+", "", line)),
                                  styles["bullet"], bulletText="•"))
        elif re.match(r"^\s*\d+[.)]\s+", line):
            num = re.match(r"^\s*(\d+)", line).group(1)
            flow.append(Paragraph(inline(re.sub(r"^\s*\d+[.)]\s+", "", line)),
                                  styles["bullet"], bulletText=f"{num}."))
        else:
            flow.append(Paragraph(inline(line), styles["body"]))
        i += 1
    return flow


def main() -> None:
    if len(sys.argv) < 3:
        raise SystemExit(__doc__)
    src, dst = Path(sys.argv[1]), Path(sys.argv[2])
    title = sys.argv[3] if len(sys.argv) > 3 else src.stem
    if not src.exists():
        raise SystemExit(f"입력 파일이 없습니다: {src}")

    font = register_font()
    styles = make_styles(font)
    md = src.read_text(encoding="utf-8")

    # 첫 줄이 제목(# )이면 표지 제목으로 끌어올리고 본문에서 제거
    lines = md.splitlines()
    if lines and lines[0].startswith("# "):
        title = lines[0][2:].strip()
        md = "\n".join(lines[1:])

    story = [Paragraph(inline(title), styles["title"])]
    from datetime import date
    story.append(Paragraph(f"김은수 · 서울대학교 영어영문학과 · {date.today():%Y-%m-%d}",
                           styles["subtitle"]))
    story += build(md, styles, font)

    dst.parent.mkdir(parents=True, exist_ok=True)
    SimpleDocTemplate(
        str(dst), pagesize=A4,
        leftMargin=2.2 * cm, rightMargin=2.2 * cm,
        topMargin=2.0 * cm, bottomMargin=2.0 * cm,
        title=title, author="김은수",
    ).build(story)
    print(f"PDF 생성: {dst}")


if __name__ == "__main__":
    main()
