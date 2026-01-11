\connect retailmart;
CREATE SCHEMA IF NOT EXISTS marketing;

CREATE TABLE IF NOT EXISTS marketing.campaigns (
  campaign_id int PRIMARY KEY,
  campaign_name varchar(100),
  start_date date,
  end_date date,
  budget numeric(12,2)
);

CREATE TABLE IF NOT EXISTS marketing.ads_spend (
  spend_id int PRIMARY KEY,
  campaign_id int REFERENCES marketing.campaigns(campaign_id),
  spend_date date,
  amount numeric(12,2),
  platform varchar(50)
);

CREATE TABLE IF NOT EXISTS marketing.email_clicks (
  email_id int PRIMARY KEY,
  campaign_id int REFERENCES marketing.campaigns(campaign_id),
  sent_date date,
  emails_sent int,
  emails_opened int,
  emails_clicked int
);
