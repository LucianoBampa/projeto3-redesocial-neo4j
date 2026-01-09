// ================================
// CONSTRAINTS
// ================================

CREATE CONSTRAINT user_id_unique IF NOT EXISTS
FOR (u:User)
REQUIRE u.user_id IS UNIQUE;

CREATE CONSTRAINT tweet_id_unique IF NOT EXISTS
FOR (t:Tweet)
REQUIRE t.tweet_id IS UNIQUE;

CREATE CONSTRAINT hashtag_name_unique IF NOT EXISTS
FOR (h:Hashtag)
REQUIRE h.name IS UNIQUE;


// ================================
// INDEXES
// ================================

CREATE INDEX user_username_index IF NOT EXISTS
FOR (u:User)
ON (u.username);

CREATE INDEX tweet_text_index IF NOT EXISTS
FOR (t:Tweet)
ON (t.text);

