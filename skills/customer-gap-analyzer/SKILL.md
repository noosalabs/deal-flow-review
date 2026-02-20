# Customer Gap Analyzer Skill

**Version:** 1.0
**Last Updated:** 2026-02-19

## Purpose

Analyze G2 and Capterra reviews for a list of competitors to surface the biggest customer complaints, unmet needs, and switching triggers in a product category.

## Inputs

- **Competitor names** — list of 3–5 competitors (from competitive-researcher skill output)
- **Product category** — for contextualizing gaps
- **Target company name** — to flag any cross-mentions in reviews

## Process

### Step 1: Find review listings
For each competitor, locate their G2 and Capterra profile:
- Search: "[competitor name] G2 reviews" and "[competitor name] Capterra reviews"
- Use browser automation (Playwright) if the page requires JavaScript rendering

### Step 2: Read negative reviews
Focus on 1-star and 2-star reviews from the last 12 months:
- What specific features are missing?
- What workflows does the product fail to support?
- Why did customers leave or consider leaving?
- What do they wish the product did differently?
- Any competitor or alternative mentioned by name?

Also read positive reviews for: what customers most value (reveals what NOT to change post-acquisition).

### Step 3: Synthesize patterns
Group complaints by theme across all reviews:

**Gap classification:**
- **Feature gap** — specific functionality missing (e.g., "no bulk export", "can't schedule reports")
- **Workflow gap** — product doesn't fit customer's process (e.g., "not designed for agencies", "too simple for our team")
- **Pricing gap** — cost vs. value mismatch (e.g., "too expensive for what it is", "limited features at this price")
- **Support gap** — responsiveness, documentation, onboarding issues

**Frequency weighting:**
- High: mentioned in >20% of negative reviews
- Medium: mentioned in 10–20% of negative reviews
- Low: mentioned in <10% of negative reviews

### Step 4: Cross-competitor analysis
- Identify gaps appearing in 2+ competitors → **CATEGORY-WIDE OPPORTUNITY**
- Flag target company mentions (switching from/to, comparisons)

## Outputs

- Gap table per competitor (gap, type, frequency)
- Category-wide opportunities list
- Target company cross-mentions
- Data confidence note (number of reviews analyzed, date range)

## Failure Modes

| Situation | Response |
|---|---|
| Fewer than 5 reviews for a competitor | Note "insufficient data", do not extrapolate |
| Reviews are too old (>2 years) | Note recency caveat, still include if no newer data |
| Paywalled review content | Note as unavailable, skip gracefully |
| No reviews found | Note "no review presence" — signals either very new or very niche product |
| Target company has no review presence | Note — this may itself be a signal (low brand awareness) |
