import { ImageResponse } from "next/og";

export const runtime = "nodejs";
export const alt = "26³, a shared glossary for the acronyms nobody explains";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function OpenGraphImage() {
  const rows = [
    ["A", "B", "C"],
    ["D", "E", "F"],
    ["P", "O", "S"],
  ];

  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          alignItems: "center",
          justifyContent: "space-between",
          padding: "64px 76px",
          backgroundColor: "#f2f5ed",
          color: "#172b28",
          fontFamily: "Arial, sans-serif",
        }}
      >
        <div style={{ display: "flex", flexDirection: "column", width: 650 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 14, marginBottom: 34 }}>
            <div
              style={{
                width: 54,
                height: 54,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                backgroundColor: "#c9ef63",
                borderRadius: 12,
                fontSize: 22,
                fontWeight: 800,
              }}
            >
              26³
            </div>
            <div style={{ fontSize: 20, fontWeight: 700, color: "#45605a" }}>
              COMPANY GLOSSARY
            </div>
          </div>
          <div style={{ display: "flex", flexDirection: "column", fontSize: 66, fontWeight: 800, lineHeight: 1.02, letterSpacing: -2 }}>
            <div>Acronyms,</div>
            <div>decoded together.</div>
          </div>
          <div style={{ marginTop: 24, fontSize: 25, color: "#526762" }}>
            The language of work, in one shared place.
          </div>
          <div style={{ display: "flex", alignItems: "center", gap: 12, marginTop: 42 }}>
            <div style={{ width: 10, height: 10, borderRadius: 5, backgroundColor: "#31766a" }} />
            <div style={{ fontSize: 18, fontWeight: 600, color: "#45605a" }}>
              17,576 possible combinations
            </div>
          </div>
        </div>
        <div style={{ display: "flex", flexDirection: "column", gap: 12, padding: 18, backgroundColor: "#e3eadc", borderRadius: 22 }}>
          {rows.map((row, rowIndex) => (
            <div key={rowIndex} style={{ display: "flex", gap: 12 }}>
              {row.map((letter) => {
                const highlighted = rowIndex === 2;
                return (
                  <div
                    key={letter}
                    style={{
                      width: 88,
                      height: 88,
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "center",
                      borderRadius: 13,
                      backgroundColor: highlighted ? "#c9ef63" : "#213b36",
                      color: highlighted ? "#172b28" : "#f7f8f3",
                      fontSize: 40,
                      fontWeight: 800,
                    }}
                  >
                    {letter}
                  </div>
                );
              })}
            </div>
          ))}
        </div>
      </div>
    ),
    size,
  );
}