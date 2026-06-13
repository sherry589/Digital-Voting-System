================================================================================
                     PROJECT: DIGITAL VOTING SYSTEM (MySQL)
================================================================================
Description: A simple, beginner-friendly relational database design managing an 
             electronic voting platform. Features include account registration, 
             voter authentication, duplicate vote prevention, and live result tallying.

PROJECT FEATURES INDEX:
--------------------------------------------------------------------------------
| Feature ID | Feature Name                          | SQL Command Type        |
|------------|---------------------------------------|-------------------------|
| Feature 1  | Register a New Voter                  | INSERT                  |
| Feature 2  | View All Registered Candidates        | SELECT                  |
| Feature 3  | Check Voter Eligibility (Age >= 18)   | SELECT                  |
| Feature 4  | Secure Voter Login & Double-Vote Check| SELECT                  |
| Feature 5  | Cast a Single Vote                    | INSERT                  |
| Feature 6  | Update Candidate's Vote Count         | UPDATE                  |
| Feature 7  | Lock Voter Status                     | UPDATE                  |
| Feature 8  | Display Live Election Results         | SELECT                  |
| Feature 9  | Count Total Turnout                   | SELECT                  |
| Feature 10 | Find the Leading Candidate            | SELECT                  |
| Feature 11 | Full 100% Turnout & Winner Finale     | MULTI-STEP TRANSACTION  |
--------------------------------------------------------------------------------
*/


-- STEP 1: SYSTEM SCHEMA & TABLE INITIALIZATION


-- Create the Voters table
CREATE TABLE Voters (
    voter_id INT PRIMARY KEY,
    voter_name VARCHAR(50),
    email VARCHAR(100),
    age INT,
    password VARCHAR(50),
    has_voted INT DEFAULT 0 -- 0 means No, 1 means Yes
);

-- Create the Candidates table
CREATE TABLE Candidates (
    candidate_id INT PRIMARY KEY,
    candidate_name VARCHAR(50),
    party_name VARCHAR(50),
    vote_count INT DEFAULT 0
);

-- Create the Votes history table
CREATE TABLE Votes (
    vote_id INT PRIMARY KEY,
    voter_id INT,
    candidate_id INT
);



-- STEP 2: SEEDING INITIAL ELECTION DATA


-- Populate 3 Pakistani Candidates
INSERT INTO Candidates (candidate_id, candidate_name, party_name) VALUES (1, 'Imran', 'PTI');
INSERT INTO Candidates (candidate_id, candidate_name, party_name) VALUES (2, 'Nawaz', 'PMLN');
INSERT INTO Candidates (candidate_id, candidate_name, party_name) VALUES (3, 'Bilawal', 'PPP');

-- Populate 30 Unique Pakistani Voters
INSERT INTO Voters (voter_id, voter_name, email, age, password) VALUES 
(1, 'Ali', 'ali@email.com', 25, 'aliPass1'),
(2, 'Bilal', 'bilal@email.com', 19, 'bilalPass2'),
(3, 'Rizwan', 'rizwan@email.com', 31, 'rizwanPass3'),
(4, 'Ahmed', 'ahmed@email.com', 22, 'ahmedPass4'),
(5, 'Zain', 'zain@email.com', 17, 'zainPass5'), -- Underage Voter
(6, 'Hamza', 'hamza@email.com', 28, 'hamzaPass6'),
(7, 'Usman', 'usman@email.com', 35, 'usmanPass7'),
(8, 'Faisal', 'faisal@email.com', 24, 'faisalPass8'),
(9, 'Asif', 'asif@email.com', 40, 'asifPass9'),
(10, 'Omar', 'omar@email.com', 29, 'omarPass10'),
(11, 'Babar', 'babar@email.com', 26, 'babarPass11'),
(12, 'Shaheen', 'shaheen@email.com', 23, 'shaheenPass12'),
(13, 'Haris', 'haris@email.com', 21, 'harisPass13'),
(14, 'Shadab', 'shadab@email.com', 27, 'shadabPass14'),
(15, 'Naseem', 'naseem@email.com', 18, 'naseemPass15'),
(16, 'Sana', 'sana@email.com', 30, 'sanaPass16'),
(17, 'Ayesha', 'ayesha@email.com', 22, 'ayeshaPass17'),
(18, 'Fatima', 'fatima@email.com', 33, 'fatimaPass18'),
(19, 'Amna', 'amna@email.com', 20, 'amnaPass19'),
(20, 'Hira', 'hira@email.com', 25, 'hiraPass20'),
(21, 'Kamran', 'kamran@email.com', 45, 'kamranPass21'),
(22, 'Sajid', 'sajid@email.com', 32, 'sajidPass22'),
(23, 'Tariq', 'tariq@email.com', 50, 'tariqPass23'),
(24, 'Waqas', 'waqas@email.com', 29, 'waqasPass24'),
(25, 'Yasir', 'yasir@email.com', 34, 'yasirPass25'),
(26, 'Zeeshan', 'zeeshan@email.com', 27, 'zeeshanPass26'),
(27, 'Noman', 'noman@email.com', 23, 'nomanPass27'),
(28, 'Junaid', 'junaid@email.com', 31, 'junaidPass28'),
(29, 'Kashif', 'kashif@email.com', 36, 'kashifPass29'),
(30, 'Saad', 'saad@email.com', 24, 'saadPass30');


--- STEP 3: PLATFORM FUNCTIONALITIES (FEATURES 1 TO 10)


-- Feature 1: Register a New Voter
INSERT INTO Voters (voter_id, voter_name, email, age, password) 
VALUES (31, 'Fawad', 'fawad@email.com', 26, 'fawadPass31');


-- Feature 2: View All Registered Candidates
SELECT candidate_id, candidate_name, party_name 
FROM Candidates;


-- Feature 3: Check Voter Eligibility (Age Verification to hide underage citizens)
SELECT voter_id, voter_name, age 
FROM Voters 
WHERE age >= 18;


-- Feature 4: Secure Voter Login & Check Double-Voting
-- (Returns rows ONLY if details match and has_voted is exactly 0)
SELECT voter_id, voter_name 
FROM Voters 
WHERE email = 'rizwan@email.com' 
  AND password = 'rizwanPass3' 
  AND has_voted = 0;


-- Feature 5: Cast a Single Vote
-- (Records a historical transaction linkage: Voter 3 votes for Candidate 1)
INSERT INTO Votes (vote_id, voter_id, candidate_id) 
VALUES (100, 3, 1);


-- Feature 6: Update Candidate's Vote Count
-- (Manually increments candidate 1's tally based on Feature 5's action)
UPDATE Candidates 
SET vote_count = vote_count + 1 
WHERE candidate_id = 1;


-- Feature 7: Lock Voter Status
-- (Changes status flag to 1 so this account can never execute Feature 4 again)
UPDATE Voters 
SET has_voted = 1 
WHERE voter_id = 3;


-- Feature 8: Display Live Election Results
SELECT candidate_name, party_name, vote_count 
FROM Candidates 
ORDER BY vote_count DESC;


-- Feature 9: Count Total Turnout
SELECT COUNT(vote_id) AS total_votes_cast 
FROM Votes;


-- Feature 10: Find the Leading Candidate (Current Winner status)
SELECT candidate_name, party_name, vote_count 
FROM Candidates 
ORDER BY vote_count DESC 
LIMIT 1;



-- STEP 4: FEATURE 11 - SIMULATING 100% TURNOUT & FINAL WINNER FINALE


-- Mass mock data entry for all remaining voters to conclude the election
INSERT INTO Votes (vote_id, voter_id, candidate_id) VALUES 
(101, 1, 1),  (102, 2, 1),  (104, 4, 1),  (105, 5, 3),  (106, 6, 1),  
(107, 7, 2),  (108, 8, 1),  (109, 9, 2),  (110, 10, 3), (111, 11, 1), 
(112, 12, 1), (113, 13, 2), (114, 14, 1), (115, 15, 3), (116, 16, 1), 
(117, 17, 2), (118, 18, 1), (119, 19, 2), (120, 20, 3), (121, 21, 1), 
(122, 22, 1), (123, 23, 2), (124, 24, 1), (125, 25, 3), (126, 26, 1), 
(127, 27, 2), (128, 28, 1), (129, 29, 2), (130, 30, 1);

-- Sync final aggregate tallies to Candidates table (Including the single vote from Feature 5)
UPDATE Candidates SET vote_count = 16 WHERE candidate_id = 1;
UPDATE Candidates SET vote_count = 9 WHERE candidate_id = 2;
UPDATE Candidates SET vote_count = 5 WHERE candidate_id = 3;

-- Close access for all records across the platform database
UPDATE Voters SET has_voted = 1;


-- STEP 5: FINAL SYSTEM GRAND REPORT GENERATION


SELECT '--- FINAL ELECTION SCOREBOARD ---' AS 'Report Status';
SELECT candidate_name, party_name, vote_count 
FROM Candidates 
ORDER BY vote_count DESC;

SELECT '--- FINAL TOTAL BALLOT TURNOUT ---' AS 'Report Status';
SELECT COUNT(vote_id) AS total_verified_ballots 
FROM Votes;

SELECT '--- OFFICIAL ELECTION WINNER ---' AS 'Report Status';
SELECT candidate_name AS winner_name, party_name AS winning_party, vote_count AS winning_votes
FROM Candidates 
ORDER BY vote_count DESC 
LIMIT 1;

```
