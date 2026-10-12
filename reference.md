# Surface Preflight — auditor checklist

Mechanical rows only. Prefer `~/.cursor/skills/birdeye-copy-skill-v2/reference.md` when that file exists.

## Copy (§5, §6, §33, §46, §48)

Flag if the staged string matches.

| Conflict | Fix |
|----------|-----|
| `Please` outside billing/legal/compliance | Drop Please. `Enter a URL` not `Please enter a URL` |
| `Successfully` on a confirmation | Past-tense verb only (`Saved`) |
| Em dash (`—` or `--` as dash) | Period, colon, or rewrite |
| `!` except one genuine milestone | Remove |
| Filler opener: Shows, Indicates, Displays, Tracks, Represents, Measures | Start with the definition |
| `customer` / `lead` / `person` on CRM/settings | `contact` (Myna healthcare/dental stays `patient`; auto stays `customer`) |
| `SMS` | `Text` |
| `sub-agent` | `another agent` |
| `Fires when` | `Starts when` |
| `BirdAI` / `Bird Ai` | `Bird AI` |
| Title case on a label (`Save Contact`) | Sentence case (`Save contact`) |
| British spelling (colour, organise) | American (color, organize) |
| `has been` in a toast | Active (`Contact saved`) |
| Over word budget | Button ≤ 3, helper ≤ 12, toast ≤ 10, error ≤ 20, empty headline ≤ 8 |

Product names stay capped: Inbox, Campaigns, Reviews, Listings, Appointments, Surveys, Webchat, Payments, Bird AI. `Save` and `Save contact` are both valid.

Name alignment: same idea, different spellings across file name, export, story `title`, story `name`, and visible copy. One row per place.

## Storybook

Sources: `AGENTS.md`, `.cursor/rules/storybook-story-required.mdc`, `.cursor/rules/storybook-new-component.mdc`, `.cursor/rules/spacing-grid.mdc`.

| Conflict | Fix |
|----------|-----|
| New file under `src/app/components/` with no story in the same change | Add `src/stories/<Name>.stories.tsx` (App views may live under `src/stories/App/…`) |
| Missing `Default` | Export `Default` |
| Story export has no sentence-case `name:` (`SparseProfile`, `WithData`) | `name: "Sparse profile"` |
| Title not `UI/` · `App/` · `Design System/` · `Content /` | Match that tree |
| Story mocks the component | Import the real component |
| Component changed, story not updated | Update the story |
| New floating panel primitive | `Sheet` `inset="floating"`; do not add a second drawer |
| Off-grid spacing in the story wrapper (`gap-3`, `p-3`, `px-5`) | 8px grid (`gap-2`, `gap-4`, `gap-6`) |

Pass rows (story exists, `Default` present) may appear as Fix `—`.

## Example `0bb45a7`

```
Subject: Expand the business profile editor and align field copy.

## 1. Copy review
| Where | Current copy | Conflict | Fix |
| SettingsBusinessDetailView.tsx → SOCIAL_URL_PLACEHOLDER | Please enter a URL | Please banned (§46.9) | Enter a URL |
| settingsBusinessProfileData.ts → custom field Region manager | Please enter the value of Region manager. | Please banned | Enter the region manager |
| settingsBusinessProfileData.ts → Medical conditions | Please enter the value of Medical conditions. | Please banned | Enter medical conditions |
| settingsBusinessProfileData.ts → Area code | Please enter the value of Area code. | Please banned | Enter the area code |
| settingsBusinessProfileData.ts → Location node id | Please enter the value of Location node id. | Please banned | Enter the location node ID |
| settingsBusinessProfileData.ts → Client notes | Please enter the value of Client notes. | Please banned | Enter client notes |
| settingsBusinessProfileData.ts → business description | …helps customers discover… | Glossary: contact, not customer (§6) | …helps contacts discover… |
| settingsBusinessProfileData.ts → Google appointment helper | Let customers make appointments… | Same glossary miss | Let contacts make appointments… |
| settingsBusinessProfileData.ts → description placeholder | …using BirdAI. | Product name is Bird AI | …using Bird AI. |
| SettingsBusinessDetailView.tsx → aria-label | BirdAI | Same name drift | Bird AI |

Style: 8 misses · Name alignment: 1 conflict (BirdAI vs Bird AI). +6 more “customers” helpers, same fix.

## 2. Storybook review
| Where | Current | Conflict | Fix |
| HoursOfOperationFields.tsx | new component, no own story in this commit | One component = one story | Add App/Settings/HoursOfOperationFields (later landed in 75740fb) |
| SettingsBusinessDetailView.stories.tsx → SparseProfile | no name: | Story names are sentence case | name: "Sparse profile" |
| SettingsBusinessDetailView.stories.tsx → ReviewsTab | no name: | Same | name: "Reviews tab" |
| SettingsMapMarkerField.stories.tsx | added in this commit | Has story — pass | — |
| SettingsBusinessDetailView.stories.tsx → Default | present | Pass | — |
```
