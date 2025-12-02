import { serve } from "https://deno.land/std@0.177.0/http/server.ts";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY");
const SERVICE_ROLE_KEY = Deno.env.get("SERVICE_ROLE_KEY");
const PROJECT_URL = Deno.env.get("PROJECT_URL");

// ---------- FIX JSON -----------
function cleanJson(text: string) {
  return text
    .replaceAll("```json", "")
    .replaceAll("```", "")
    .trim();
}

// ---------- CALL GEMINI ----------
async function generateEventsAI() {
  const prompt = `
Return ONLY a valid JSON array.
No text. No markdown.

Generate 5 **future** upcoming events in Saudi Arabia (2025 or later).

Each event must contain exactly:

{
  "id": "uuid",                     // auto-generate real uuid
  "title": "string",
  "description": "string",
  "location": "string",
  "date": "YYYY-MM-DD",              // must be future date
  "category": "string"               // event category, e.g. Music, Sports, Tech
}

Important rules:
- Dates MUST be from 2025-01-01 or later
- Output MUST be ONLY the JSON array
`;

  const response = await fetch(
    `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}`,
    {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        contents: [{ parts: [{ text: prompt }] }],
      }),
    }
  );

  const data = await response.json();
  console.log("RAW:", data);

  const text = data.candidates?.[0]?.content?.parts?.[0]?.text || "[]";
  const cleaned = cleanJson(text);

  try {
    return JSON.parse(cleaned);
  } catch {
    console.error("JSON invalid:", cleaned);
    return [];
  }
}

// ---------- SAVE TO SUPABASE ----------
async function saveEvents(events: any[]) {
  if (!events.length) return [];

  const res = await fetch(`${PROJECT_URL}/rest/v1/events`, {
    method: "POST",
    headers: {
      apikey: SERVICE_ROLE_KEY!,
      Authorization: `Bearer ${SERVICE_ROLE_KEY}`,
      "Content-Type": "application/json",
      Prefer: "return=representation",
    },
    body: JSON.stringify(events),
  });

  return await res.json();
}

// ---------- MAIN FUNCTION ----------
serve(async () => {
  const events = await generateEventsAI();
  const saved = await saveEvents(events);

  return new Response(
    JSON.stringify({
      message: "AI generated events with categories!",
      events: saved,
    }),
    { headers: { "Content-Type": "application/json" } }
  );
});
