BEGIN;

--
-- CREATE POSTGIS EXTENSION IF AVAILABLE
--
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'postgis') THEN
    EXECUTE 'CREATE EXTENSION IF NOT EXISTS postgis';
  ELSE
    RAISE EXCEPTION 'Required extension "postgis" is not available on this instance. Please install PostGIS. For instructions, see https://docs.serverpod.dev/upgrading/upgrade-to-postgis.';
  END IF;
END
$$;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "declined_edge" (
    "id" bigserial PRIMARY KEY,
    "fromListingId" bigint NOT NULL,
    "toListingId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "declined_edge_pair_idx" ON "declined_edge" USING btree ("fromListingId", "toListingId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "exchange" (
    "id" bigserial PRIMARY KEY,
    "slug" text NOT NULL,
    "name" text NOT NULL,
    "cadre" text NOT NULL,
    "scope" text NOT NULL,
    "state" text,
    "description" text NOT NULL,
    "maxLoopSize" bigint NOT NULL DEFAULT 4,
    "acceptWindowMinutes" bigint NOT NULL DEFAULT 2880,
    "isSandbox" boolean NOT NULL DEFAULT false,
    "isSimulated" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "exchange__slug__unique_idx" ON "exchange" USING btree ("slug");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "listing" (
    "id" bigserial PRIMARY KEY,
    "memberId" bigint NOT NULL,
    "exchangeId" bigint NOT NULL,
    "currentPlaceId" bigint NOT NULL,
    "postTitle" text NOT NULL,
    "yearsInPost" bigint NOT NULL DEFAULT 0,
    "status" text NOT NULL DEFAULT 'active'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "listing_member_exchange_idx" ON "listing" USING btree ("memberId", "exchangeId");
CREATE INDEX "listing_exchange_status_idx" ON "listing" USING btree ("exchangeId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "loop_event" (
    "id" bigserial PRIMARY KEY,
    "loopId" bigint NOT NULL,
    "kind" text NOT NULL,
    "seatPosition" bigint,
    "at" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "loop_event_loop_idx" ON "loop_event" USING btree ("loopId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "loop_seat" (
    "id" bigserial PRIMARY KEY,
    "loopId" bigint NOT NULL,
    "listingId" bigint NOT NULL,
    "memberId" bigint NOT NULL,
    "position" bigint NOT NULL,
    "fromPlaceId" bigint NOT NULL,
    "toPlaceId" bigint NOT NULL,
    "wishRank" bigint NOT NULL,
    "km" double precision NOT NULL,
    "response" text NOT NULL DEFAULT 'pending'::text,
    "respondedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "loop_seat_loop_idx" ON "loop_seat" USING btree ("loopId");
CREATE INDEX "loop_seat_member_idx" ON "loop_seat" USING btree ("memberId");
CREATE INDEX "loop_seat_listing_idx" ON "loop_seat" USING btree ("listingId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "member" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid,
    "displayName" text NOT NULL,
    "phone" text,
    "contactEmail" text,
    "isBot" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "member__authUserId__unique_idx" ON "member" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "place" (
    "id" bigserial PRIMARY KEY,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "state" text NOT NULL,
    "point" geography(Point,4326) NOT NULL,
    "population" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE UNIQUE INDEX "place__code__unique_idx" ON "place" USING btree ("code");
CREATE INDEX "place_state_idx" ON "place" USING btree ("state");
CREATE INDEX "place_point_idx" ON "place" USING gist ("point");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "solver_run" (
    "id" bigserial PRIMARY KEY,
    "exchangeId" bigint NOT NULL,
    "at" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "trigger" text NOT NULL,
    "activeListings" bigint NOT NULL,
    "edgeCount" bigint NOT NULL,
    "coreSize" bigint NOT NULL,
    "candidateCount" bigint NOT NULL,
    "loopsProposed" bigint NOT NULL,
    "peopleInLoops" bigint NOT NULL,
    "pairwisePeople" bigint NOT NULL,
    "elapsedMs" bigint NOT NULL
);

-- Indexes
CREATE INDEX "solver_run_exchange_idx" ON "solver_run" USING btree ("exchangeId", "at");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "swap_loop" (
    "id" bigserial PRIMARY KEY,
    "exchangeId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'proposed'::text,
    "size" bigint NOT NULL,
    "score" double precision NOT NULL,
    "publicCode" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deadline" timestamp without time zone NOT NULL,
    "resolvedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "swap_loop__publicCode__unique_idx" ON "swap_loop" USING btree ("publicCode");
CREATE INDEX "swap_loop_exchange_status_idx" ON "swap_loop" USING btree ("exchangeId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "wish" (
    "id" bigserial PRIMARY KEY,
    "listingId" bigint NOT NULL,
    "placeId" bigint NOT NULL,
    "radiusKm" bigint NOT NULL DEFAULT 0,
    "rank" bigint NOT NULL,
    "point" geography(Point,4326)
);

-- Indexes
CREATE INDEX "wish_listing_idx" ON "wish" USING btree ("listingId");
CREATE INDEX "wish_point_idx" ON "wish" USING gist ("point");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "declined_edge"
    ADD CONSTRAINT "declined_edge_fk_0"
    FOREIGN KEY("fromListingId")
    REFERENCES "listing"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "declined_edge"
    ADD CONSTRAINT "declined_edge_fk_1"
    FOREIGN KEY("toListingId")
    REFERENCES "listing"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "listing"
    ADD CONSTRAINT "listing_fk_0"
    FOREIGN KEY("memberId")
    REFERENCES "member"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "listing"
    ADD CONSTRAINT "listing_fk_1"
    FOREIGN KEY("exchangeId")
    REFERENCES "exchange"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "listing"
    ADD CONSTRAINT "listing_fk_2"
    FOREIGN KEY("currentPlaceId")
    REFERENCES "place"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "loop_event"
    ADD CONSTRAINT "loop_event_fk_0"
    FOREIGN KEY("loopId")
    REFERENCES "swap_loop"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "loop_seat"
    ADD CONSTRAINT "loop_seat_fk_0"
    FOREIGN KEY("loopId")
    REFERENCES "swap_loop"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "loop_seat"
    ADD CONSTRAINT "loop_seat_fk_1"
    FOREIGN KEY("listingId")
    REFERENCES "listing"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "loop_seat"
    ADD CONSTRAINT "loop_seat_fk_2"
    FOREIGN KEY("memberId")
    REFERENCES "member"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "loop_seat"
    ADD CONSTRAINT "loop_seat_fk_3"
    FOREIGN KEY("fromPlaceId")
    REFERENCES "place"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "loop_seat"
    ADD CONSTRAINT "loop_seat_fk_4"
    FOREIGN KEY("toPlaceId")
    REFERENCES "place"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "solver_run"
    ADD CONSTRAINT "solver_run_fk_0"
    FOREIGN KEY("exchangeId")
    REFERENCES "exchange"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "swap_loop"
    ADD CONSTRAINT "swap_loop_fk_0"
    FOREIGN KEY("exchangeId")
    REFERENCES "exchange"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "wish"
    ADD CONSTRAINT "wish_fk_0"
    FOREIGN KEY("listingId")
    REFERENCES "listing"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "wish"
    ADD CONSTRAINT "wish_fk_1"
    FOREIGN KEY("placeId")
    REFERENCES "place"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR loop
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('loop', '20261013055703393', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261013055703393', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
