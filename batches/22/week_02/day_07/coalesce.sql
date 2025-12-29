 📘 TOPIC 2.1: COALESCE - Replace NULLs Smartly

 Definition

Technical Definition:
COALESCE is a function that returns the first non-NULL value from a list of arguments. It evaluates arguments from left to right and returns the first value that is not NULL. If all arguments are NULL, it returns NULL.

Layman's Terms:
Imagine you're hungry at midnight and checking food options! 🍕

You think: "Let me check what's available..."
- First choice: Biryani from fridge → NOT THERE (NULL)
- Second choice: Maggi in kitchen → NOT THERE (NULL)  
- Third choice: Biscuits in drawer → FOUND IT! ✅

You stop looking and eat the biscuits!

COALESCE does exactly this - it checks options one by one and returns the FIRST thing that exists (not NULL). It's your "backup plan" function!

---

 Story/Analogy

🎬 THE STORY: The Paytm Customer Support Nightmare!

You're a Data Analyst at Paytm. The support team is panicking:

"Our customer contact report shows BLANK phone numbers! We can't call them!"

You check the data:
- Some customers have mobile_phone filled
- Some have home_phone filled  
- Some have work_phone filled
- Some unlucky ones have ALL THREE empty! 😱

The support manager needs ONE reliable contact number per customer.

You write the magic query:

SELECT 
    customer_name,
    COALESCE(mobile_phone, home_phone, work_phone, 'NO CONTACT') AS contact_number
FROM customers;

This does:
1. First, check mobile_phone → if exists, use it!
2. If mobile is NULL, check home_phone → if exists, use it!
3. If home is NULL, check work_phone → if exists, use it!
4. If ALL are NULL, show 'NO CONTACT' (so support knows to skip)

The support team: "You're a genius! Our report is fixed!"

COALESCE = Your data's safety net! It ALWAYS gives you something to work with! 🛡️