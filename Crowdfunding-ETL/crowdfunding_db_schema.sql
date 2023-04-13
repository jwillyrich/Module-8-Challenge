SELECT cf_id, backer_counts
INTO backer_by_cf_id
FROM campaigns
WHERE (outcome = 'live')
GROUP BY cf_id
ORDER BY backer_count DESC;

SELECT * FROM backers_by_cf_id;

SELECT ca.cf_id, ca.backer_counts
INTO backers_by_cf_id
FROM campaigns AS ca
	LEFT JOIN backers AS ba
	ON ba.cf_id = ca.cf_id
WHERE (ca.outcome = 'live')
GROUP BY ca.cf_id
ORDER BY ca.backers_count DESC;

SELECT * FROM backers_by_cf_id;


SELECT cf_id, COUNT(backer_id) AS count_fr_backers
INTO backers_by_cf_id_fr_backers
FROM backers
GROUP BY cf_id
ORDER BY count_fr_backers DESC;
SCHEMASELECT * FROM backers_by_cf_id_fr_backers;

DROP TABLE IF EXISTS campaign_backers_diff CASCADE;
SELECT ca.cf_id,
	ca.backers_count,
	ba.count_fr_backers
INTO campaign_backers_diff
FROM backers_by_cf_id AS ca
	LEFT JOIN backers_by_cf_id_fr_backers AS ba
	ON ca.cf_id=ba.cf_id
ORDER BY count_fr_backers DESC;
SELECT * FROM campaign_backers_diff;

SELECT co.first_name,
	co.last_name,
	co.email,
	(ca.goal - ca.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM campaign AS ca
	LEFT JOIN contacts AS co
	ON co.contact_id = ca.contact_id
WHERE (ca.outcome = 'live')
ORDER BY "Remaining Goal Amount" DESC;

SELECT * FROM email_contacts_remaining_goal_amount;


SELECT ba.email,
	ba.first_name,
	ba.last_name,
	ca.cf_id,
	ca.company_name,
	ca.description,
	ca.end_date,
	(ca.goal - ca.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers AS ba
	LEFT JOIN campaign AS ca
	ON ca.cf_id = ba.cf_id
WHERE (ca.outcome = 'live')
ORDER BY ba.last_name, ba.email ASC;

SELECT * FROM email_backers_remaining_goal_amount;


SELECT * FROM category;
SELECT * FROM subcategory;
SELECT * FROM contacts;
SELECT * FROM campaign;
SELECT * FROM backers;
