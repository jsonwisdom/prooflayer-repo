# Gajdusek NYC / SDNY Nexus Discovery v0.1

**Date:** 2026-08-20  
**State:** DISCOVERY / NON-CANON / RECEIPTS-FIRST  
**Wrapper:** BoxDee  
**Parent case:** `GAJDUSEK_PROTECTOR_KNOWLEDGE_V0_1`

## Purpose

Test whether New York City or the Southern District of New York has a factual, records, witness, venue, or investigative nexus to the Gajdusek protector-knowledge case. This is a jurisdiction-discovery rail, not an accusation against SDNY, DOJ, New York institutions, or any individual.

## Current ruling

```text
NEW_YORK_NEXUS       = OBSERVED
SDNY_VENUE_NEXUS     = HOLD
SDNY_CASE_NEXUS      = HOLD
SDNY_PROTECTOR_CLAIM = REJECTED_ABSENT_EVIDENCE
```

## Concrete New York lead

Contemporaneous Washington Post reporting on Gajdusek's April 1996 bail hearing states that Frederick County State's Attorney Scott Rolle argued Gajdusek was a flight risk because he "also has a home in New York." The report does not identify the county or address.

Source: https://www.washingtonpost.com/archive/politics/1996/04/07/nobel-laureate-is-released-after-posting-350000-bail/bb5086ee-e7a8-44f5-8c68-fcd3f1af93b7/

## Background-only New York links

Gajdusek was born in Yonkers, New York, and had earlier scientific ties to New York, including postdoctoral research at Columbia. These facts establish historical New York connections but do not establish venue, knowledge, facilitation, or criminal conduct in SDNY.

## SDNY boundary

The U.S. Attorney's Office for the Southern District of New York covers Manhattan, the Bronx, Dutchess, Orange, Putnam, Rockland, Sullivan, and Westchester Counties and prosecutes violations of federal law.

Official source: https://www.justice.gov/usao-sdny/about-district

Until the 1996 New York home is tied to one of those counties—or another relevant act, record, witness, or investigation is tied to the district—`SDNY_VENUE_NEXUS = HOLD`.

## NYC / SDNY discovery rail

### 1. Home-location receipt
Identify the county and ownership/occupancy record for the "home in New York" referenced by prosecutor Scott Rolle in April 1996. Prefer historical deed, tax, estate, court, or contemporaneous government records. Do not publish unrelated private addresses.

### 2. Conduct nexus
Determine whether any relevant guardianship, travel, immigration, lodging, financial support, witness contact, or alleged abuse was connected to that New York property or another SDNY location. Victim/minor identities and addresses remain redacted unless already lawfully public and necessary to the evidentiary claim.

### 3. Federal investigative nexus
Search for records showing FBI New York Field Office, SDNY USAO, federal grand-jury, subpoena, mutual-legal-assistance, immigration, or other federal investigative activity connected to Gajdusek. Absence of a public hit is not proof no record exists.

### 4. Maryland prosecution records
Prioritize the 1996–97 Maryland prosecution records for references to New York property, witnesses, travel, supporters, bail sureties, witness interference, or federal referrals. The unnamed supporter remains `IDENTITY = HOLD`.

### 5. Management WHO nodes
Continue de-anonymization of NINDS management through historical organizational charts, personnel directories, OIG interview memoranda, NIH correspondence, and decision records. A management title alone does not prove knowledge.

### 6. New York institutional archives
New York academic or scientific affiliations may be searched for correspondence or contemporaneous records only when they connect to a material case node. Association alone remains non-evidentiary.

### 7. DOJ routing rule
Historical records discovery should proceed through public-record and archival channels first. A criminal referral to SDNY would require evidence of a federal offense plus a sufficient SDNY nexus. This case file does not make such a referral.

## De-anonymization promotion test

`WHO -> WHAT THEY KNEW -> DATE -> CONTEMPORANEOUS RECEIPT -> ACTION/OMISSION -> MATERIAL EFFECT -> ALTERNATIVE EXPLANATION -> JURISDICTION/NEXUS`

A name may not be promoted from `HOLD` based only on rumor, proximity, employment, friendship, scientific collaboration, post-conviction sympathy, or mention in a journal.

## Priority questions

1. Where exactly was the New York home identified during the 1996 bail proceeding?
2. Who owned it and who used it during the relevant years?
3. Did any children, witnesses, guardianship records, travel records, or support transactions connect to it?
4. Did Maryland prosecutors or the FBI identify New York witnesses or conduct?
5. Was any matter referred to the FBI New York Field Office or SDNY USAO?
6. Do historical federal records identify an SDNY grand-jury/subpoena or related federal proceeding?
7. Does any New York institutional archive contain contemporaneous knowledge receipts rather than merely professional correspondence?

## Case invariant

```text
New York connection != SDNY jurisdiction
SDNY jurisdiction != SDNY involvement
SDNY involvement != protection
Names remain HOLD until receipts bind knowledge and conduct
```
