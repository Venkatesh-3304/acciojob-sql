-- ═══════════════════════════════════════════════════════════
-- FIXED LENGTH: CHAR(n)
-- ═══════════════════════════════════════════════════════════

-- Always uses exactly n bytes (padded with spaces if shorter)
column_name CHAR(10)      -- Always 10 characters

-- Example: PAN Card (always EXACTLY 10 characters)
pan_card CHAR(10)         -- "ABCDE1234F"

-- ═══════════════════════════════════════════════════════════
-- VARIABLE LENGTH: VARCHAR(n)
-- ═══════════════════════════════════════════════════════════

-- Uses only the space needed, up to maximum n characters
column_name VARCHAR(50)   -- Up to 50 characters
column_name VARCHAR(100)  -- Up to 100 characters

-- Example: Customer names (vary in length)
full_name VARCHAR(100)    -- "Raj" or "Sri Venkatanarasimha..."

-- ═══════════════════════════════════════════════════════════
-- UNLIMITED LENGTH: TEXT
-- ═══════════════════════════════════════════════════════════

-- No length limit (theoretically up to 1GB!)
column_name TEXT

-- Example: Product reviews, descriptions, comments
review_text TEXT          -- Can be any length
description TEXT          -- Full product description


You''re building a KYC (Know Your Customer) system for a fintech company like PhonePe or Paytm. 
You need to store various Indian identity documents with strict validation.

-- KYC Document Storage System
CREATE TABLE customer_kyc (
	kyc_id SERIAL,
    customer_id INTEGER,

	 -- PAN Card (ALWAYS exactly 10 alphanumeric characters)
    pan_number CHAR(10),               -- "ABCDE1234F"
    pan_name VARCHAR(100),             -- Name as per PAN
    
    -- Aadhaar (ALWAYS exactly 12 digits - but store as CHAR!)
    aadhaar_number CHAR(12),           -- "234567891234" (preserve leading zeros!)
    aadhaar_name VARCHAR(100),         -- Name as per Aadhaar
	
    -- Passport (varies by country: Indian = 1 letter + 7 digits)
    passport_number VARCHAR(20),       -- "J1234567" (Indian) or longer for others
    passport_country CHAR(2),          -- ISO country code: "IN", "US", "UK"
    
    -- Driving License (varies by state and format)
    dl_number VARCHAR(20),             -- "KA-01-2020-0001234"
    dl_state CHAR(2),                  -- State code: "KA", "MH", "DL"
    
    -- Voter ID (EPIC number - 10 alphanumeric)
    voter_id CHAR(10),                 -- "ABC1234567"
    
    -- Bank Account
    bank_account_number VARCHAR(20),   -- 9-18 digits (varies by bank)
    ifsc_code CHAR(11),                -- Always 11 characters: "SBIN0001234"
    bank_name VARCHAR(100),            -- "State Bank of India"

    -- GSTIN (for business accounts)
    gstin VARCHAR(15),                 -- "22AAAAA0000A1Z5"
    
    -- Address (long text)
    permanent_address TEXT,            -- Full address (any length)
    
    -- Verification notes
    verification_notes TEXT,           -- Officer's comments
    verification_status VARCHAR(20)    -- "pending", "verified", "rejected"
);


-- Insert sample KYC data
INSERT INTO customer_kyc (
    customer_id,
    pan_number, pan_name,
    aadhaar_number, aadhaar_name,
    passport_number, passport_country,
    dl_number, dl_state,
    voter_id,
    bank_account_number, ifsc_code, bank_name,
    gstin,
    permanent_address,
    verification_notes, verification_status
) VALUES (
    1001,
    'ABCDE1234F', 'PRIYA SHARMA',
    '234567891234', 'PRIYA SHARMA',
    'J1234567', 'IN',
    'KA-01-2020-0001234', 'KA',
    'ABC1234567',
    '1234567890123456', 'SBIN0001234', 'State Bank of India',
    '29AABCU9603R1ZM',
    '123, MG Road, Indiranagar, Bangalore, Karnataka - 560038',
    'All documents verified successfully. Address proof matches Aadhaar.',
    'verified'
);
	
select * from customer_kyc;

Using CHAR where length is FIXED:
   • Ensures data quality (rejects wrong-length input)
   • Slightly faster string comparisons
   • Makes validation easier

Using VARCHAR where length VARIES:
   • Saves storage space
   • Accommodates different formats
   • Flexible for different sources
══════════════════════════════════════



-- Multi-language Content Management System
CREATE TABLE news_articles (
    article_id SERIAL,
    
    -- Article identifiers
    article_uuid CHAR(36),                 -- UUID: "550e8400-e29b-41d4-a716-446655440000"
    slug VARCHAR(200),                     -- URL slug: "pm-announces-new-policy-2024"
    
    -- Language and locale
    language_code CHAR(2),                 -- "en", "hi", "ta", "te", "bn"
    region_code CHAR(5),                   -- "en-IN", "hi-IN", "ta-IN"
    
    -- Headlines (multiple lengths for different displays)
    headline_main VARCHAR(200),            -- Main headline
    headline_short VARCHAR(80),            -- For mobile/tickers
    headline_seo VARCHAR(70),              -- SEO optimized (Google cuts at ~60)
    
    -- Article content
    summary VARCHAR(500),                  -- Article summary
    content_body TEXT,                     -- Full article (could be 5000+ words)
    
    -- Hindi article example:
    -- headline_main: "प्रधानमंत्री ने नई योजना की घोषणा की"
    -- content_body: Full article in Hindi...
    
    -- Tamil article example:
    -- headline_main: "பிரதமர் புதிய திட்டத்தை அறிவித்தார்"
    
    -- SEO metadata
    meta_title VARCHAR(150),                -- Browser tab title
    meta_description VARCHAR(160),         -- Google snippet (155-160 chars ideal)
    meta_keywords VARCHAR(200),            -- SEO keywords
    canonical_url VARCHAR(500),            -- Full canonical URL
    
    -- Categorization
    category_code CHAR(5),                 -- "SPORT", "POLIT", "TECH", "ENTER"
    subcategory VARCHAR(50),               -- "Cricket", "Elections", etc.
    tags TEXT,                             -- Comma-separated tags (can be many)
    
    -- Author info
    author_id INTEGER,
    author_byline VARCHAR(100),            -- "By Priya Sharma, Senior Editor"
    
    -- Media references
    featured_image_url VARCHAR(500),       -- CDN URL for main image
    image_alt_text VARCHAR(200),           -- Accessibility description
    video_embed_code TEXT,                 -- Full embed HTML (can be long)
    
    -- Social sharing
    twitter_text VARCHAR(280),             -- Twitter character limit
    whatsapp_text VARCHAR(1000),           -- WhatsApp preview text
    
    -- Timestamps (we'll learn DATE types next!)
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    published_at TIMESTAMP,
    
    -- Status
    status VARCHAR(20),                    -- "draft", "review", "published", "archived"
    editor_notes TEXT                      -- Internal notes (can be lengthy)
);


-- Insert English article
INSERT INTO news_articles (
    article_uuid, slug,
    language_code, region_code,
    headline_main, headline_short, headline_seo,
    summary, content_body,
    meta_title, meta_description, meta_keywords, canonical_url,
    category_code, subcategory, tags,
    author_id, author_byline,
    featured_image_url, image_alt_text,
    twitter_text, whatsapp_text,
    status, editor_notes
) VALUES (
    '550e8400-e29b-41d4-a716-446655440001',
    'india-wins-cricket-world-cup-2024',
    'en', 'en-IN',
    'India Wins Cricket World Cup 2024: Historic Victory in Final Against Australia',
    'India Wins World Cup 2024!',
    'India Wins Cricket World Cup 2024 - Historic Final Victory',
    'Team India created history by winning the ICC Cricket World Cup 2024, defeating Australia by 7 wickets in a thrilling final at the Narendra Modi Stadium in Ahmedabad.',
    'AHMEDABAD: In what will be remembered as one of the greatest moments in Indian cricket history, Team India lifted the ICC Cricket World Cup 2024 trophy after a comprehensive 7-wicket victory against Australia at the Narendra Modi Stadium. Captain Rohit Sharma led from the front with a magnificent century, while Virat Kohli provided the finishing touches with an unbeaten 85. The bowling attack, spearheaded by Jasprit Bumrah, dismantled the Australian batting lineup early, restricting them to 256. In response, India chased down the target with 15 balls to spare, sparking celebrations across the nation. This victory marks India''s third World Cup triumph after 1983 and 2011, and comes 13 years after their last championship. The team''s journey through the tournament was remarkable, winning all 11 matches on their path to glory. Prime Minister Narendra Modi congratulated the team, calling it "a proud moment for 1.4 billion Indians." Celebrations erupted across major cities, with fans gathering at Gateway of India in Mumbai, India Gate in Delhi, and Marina Beach in Chennai. The BCCI announced a bonus of ₹10 crore for the team, while several state governments announced additional rewards for players from their states.',
    'India Wins Cricket World Cup 2024 | Historic Final Victory vs Australia',
    'India wins Cricket World Cup 2024, defeating Australia by 7 wickets in final. Rohit Sharma century leads historic victory at Ahmedabad.',
    'cricket world cup 2024, india wins, rohit sharma, virat kohli, bumrah, australia',
    'https://news.example.com/sports/cricket/india-wins-cricket-world-cup-2024',
    'SPORT', 'Cricket',
    'cricket, world cup, india, australia, rohit sharma, virat kohli, bumrah, ahmedabad, final, 2024, icc, bcci',
    1001, 'By Rajesh Kumar, Sports Editor',
    'https://cdn.example.com/images/india-wc-2024-trophy.jpg',
    'Indian cricket team celebrating with World Cup 2024 trophy at Ahmedabad',
    '🏆 INDIA WINS WORLD CUP 2024! 🇮🇳 Historic victory against Australia! Rohit Sharma century seals the deal! #INDvAUS #CWC2024 #BleedBlue',
    '🏏🏆 *BREAKING* India wins Cricket World Cup 2024! Beat Australia by 7 wickets. Rohit Sharma 100*, Kohli 85*. Historic moment! 🇮🇳',
    'published',
    'Fact-checked with BCCI press release. Updated with PM''s statement at 8:45 PM.'
);


-- Insert Hindi article
INSERT INTO news_articles (
    article_uuid, slug,
    language_code, region_code,
    headline_main, headline_short, headline_seo,
    summary, content_body,
    meta_title, meta_description,
    category_code, subcategory,
    author_id, author_byline,
    status
) VALUES (
    '550e8400-e29b-41d4-a716-446655440002',
    'bharat-ne-cricket-world-cup-2024-jeeta',
    'hi', 'hi-IN',
    'भारत ने क्रिकेट विश्व कप 2024 जीता: ऑस्ट्रेलिया पर ऐतिहासिक जीत',
    'भारत ने विश्व कप जीता! 🏆',
    'भारत ने क्रिकेट विश्व कप 2024 जीता - ऐतिहासिक जीत',
    'टीम इंडिया ने अहमदाबाद के नरेंद्र मोदी स्टेडियम में ऑस्ट्रेलिया को 7 विकेट से हराकर आईसीसी क्रिकेट विश्व कप 2024 जीतकर इतिहास रच दिया।',
    'अहमदाबाद: भारतीय क्रिकेट इतिहास के सबसे महान क्षणों में से एक में, टीम इंडिया ने नरेंद्र मोदी स्टेडियम में ऑस्ट्रेलिया पर 7 विकेट से शानदार जीत के बाद आईसीसी क्रिकेट विश्व कप 2024 ट्रॉफी उठाई। कप्तान रोहित शर्मा ने शानदार शतक के साथ अगुवाई की, जबकि विराट कोहली ने 85 रनों की नाबाद पारी के साथ मैच को अंजाम दिया। जसप्रीत बुमराह की अगुवाई में गेंदबाजी आक्रमण ने ऑस्ट्रेलियाई बल्लेबाजी क्रम को जल्दी ध्वस्त कर दिया और उन्हें 256 रनों पर रोक दिया।',
    'भारत ने क्रिकेट विश्व कप 2024 जीता | ऑस्ट्रेलिया पर ऐतिहासिक जीत',
    'भारत ने क्रिकेट विश्व कप 2024 जीता, फाइनल में ऑस्ट्रेलिया को 7 विकेट से हराया। रोहित शर्मा का शतक।',
    'SPORT', 'क्रिकेट',
    1002, 'राजेश कुमार, खेल संपादक',
    'published'
);

select * from news_articles

Unicode Support:
   PostgreSQL VARCHAR and TEXT fully support UTF-8!
   → Hindi: "प्रधानमंत्री ने नई योजना की घोषणा की"
   → Tamil: "பிரதமர் புதிய திட்டத்தை அறிவித்தார்"
   → Telugu: "ప్రధాని కొత్త పథకం ప్రకటించారు"
   → Bengali: "প্রধানমন্ত্রী নতুন প্রকল্প ঘোষণা করলেন"