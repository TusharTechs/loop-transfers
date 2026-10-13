# Data Sources

Generated: 2026-10-12

## 1. `loop_server/data/india_districts.json`

List of 763 Indian districts (36 states/UTs) with a representative coordinate and population, used for location search and distance/proximity matching.

Record shape: `{"code","name","state","lat","lon","population"}` (+ `"manual": true` where noted below). Sorted by state, then name. `code` is `IN-<geonameid>`.

- Source: GeoNames, `https://download.geonames.org/export/dump/IN.zip` (all India features) and `https://download.geonames.org/export/dump/admin1CodesASCII.txt` (state names). Downloaded 2026-10-12.
- License: Creative Commons Attribution 4.0 (CC BY 4.0). **Required attribution text: "Data © GeoNames (geonames.org), CC BY 4.0"** (show it in the app's About/Credits screen).

Processing:
1. Keep rows with feature class `A`, feature code `ADM2` (763 rows); state resolved from the admin1 code via `admin1CodesASCII.txt` (`IN.<code>`).
2. Use the ASCII name; collapse whitespace; strip a leading `District ` and a trailing ` District`/` district`.
3. Coordinates rounded to 4 dp. Population = GeoNames population if > 0; otherwise sum of populations of `P`-class features with the same admin1+admin2 codes (111 districts); otherwise 0 (11 recently created districts in Arunachal Pradesh, Assam, Manipur and Meghalaya). Population figures are rough (mostly 2011 Census-era) and some estimates are low (e.g. Mumbai City comes out at 700,000).
4. Deduplicate by (state, name) (no duplicates found); sort.
5. Spelling/modern-name normalisation via a small rename map in the generator, only where unambiguous, e.g. Karnataka: Bangalore Urban -> Bengaluru Urban, Mysore -> Mysuru, Belgaum -> Belagavi, Gulbarga -> Kalaburagi, etc.; Maharashtra: Bid -> Beed, Gondiya -> Gondia, Raigarh -> Raigad, Ahmadnagar -> Ahmednagar, Mumbai -> Mumbai City; plus spelling fixes such as Ahmadabad -> Ahmedabad, Haora -> Howrah, Pattanamtitta -> Pathanamthitta. `Aurangabad` and `Osmanabad` are intentionally kept (not the 2023 names). `Ahmednagar` is not renamed to Ahilyanagar.

Manual corrections (flagged `"manual": true`):
- GeoNames lists five Maharashtra districts as `... Division` records at ADM2 level (they carry the 2011 district populations): Pune, Nagpur, Nashik, Amravati, Satara. They were renamed to the district names (`Pune Division` -> `Pune`, etc.). GeoNames coordinates and populations were kept as-is; the coordinates are the GeoNames point for that record (roughly the district's principal city/centre, e.g. Pune is ~27 km from the city centre).
- No districts were added from scratch: after this fix Maharashtra has 36 and Karnataka 31 districts, matching the current counts.

Known caveats: GeoNames is behind on recent district reorganisations (e.g. Rajasthan, Madhya Pradesh, Gujarat, Odisha, Assam new districts may be missing or use old names). Coordinates are GeoNames admin-centre/centroid points, not exact centroids.

## 2. `loop_flutter/assets/geo/india_states.json`

Simplified polygon geometry of India for a stylised `CustomPainter` map (no tiles).

Format: `{"bbox":[minLon,minLat,maxLon,maxLat],"outline":[ring,...],"states":[{"name","rings":[ring,...]},...]}` where each ring is `[[lon,lat],...]` (closed, outer rings only, 3 dp). Paint order suggestion: fill `outline`, fill/stroke `states`, then stroke `outline`.

- Sources (Natural Earth v5.1.1, public domain):
  - National outline, India point-of-view: `https://naciscdn.org/naturalearth/10m/cultural/ne_10m_admin_0_countries_ind.zip` (feature `ADM0_A3 == IND`).
  - States/UTs: `https://naciscdn.org/naturalearth/10m/cultural/ne_10m_admin_1_states_provinces.zip` (filtered to `adm0_a3 == IND`; 36 states/UTs).
- License: Natural Earth is public domain (attribution optional: "Made with Natural Earth").

Processing:
1. The admin-1 layer covers only Indian-administered territory (J&K ends at ~34.8N, Ladakh excludes Gilgit-Baltistan/Aksai Chin). The India-POV national outline minus the union of the states (about 11.5 sq. deg) was computed and added to Jammu and Kashmir (PoK area, via an approximate cut polygon) and Ladakh (Gilgit-Baltistan, Aksai Chin, Shaksgam), so the state fills match the India-POV outline. The J&K/Ladakh split inside the claimed area is approximate.
2. Tiny parts removed (< 0.003 sq. deg., i.e. ~30 sq. km), except Lakshadweep, Puducherry, and Dadra & Nagar Haveli and Daman & Diu parts (>= 0.0002) and the main Andaman & Nicobar islands (>= 0.0015). Interior holes dropped (outer rings only).
3. State borders were noded and merged into shared segments, each simplified with Douglas-Peucker at 0.02 degrees (shared borders stay consistent between neighbouring states), then re-polygonised and assigned back to states. The national outline was simplified independently (0.02 deg for large polygons, 0.01 for small), so outline and state edges can differ by ~1 px at 1000 px width; drawing the filled outline underneath the states hides this.
4. Coordinates rounded to 3 decimals.

Caveats: a few tiny enclaves (Yanam, Mahe, Diu) are approximate/merged into neighbouring state polygons because of Natural Earth's source geometry. State names match the `state` field in `india_districts.json` exactly (`Andaman and Nicobar Islands` is renamed from Natural Earth's `Andaman and Nicobar`).

## Regenerating

Both files were produced with throwaway Python scripts (shapely + pyshp) from the downloaded archives listed above; no scripts are checked in.
