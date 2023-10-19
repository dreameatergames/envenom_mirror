$frame crawl1 crawl2 crawl3 crawl4 crawl5 crawl6 crawl7 crawl8 crawl9 crawl10

$frame squished1

//

float() FindChase =
{
	local entity hate;

	hate = find(world, teams, self.enemyteam);
	while (hate)
	{
		if (visible(hate))
			break;
		hate = find(hate, teams, self.enemyteam);
	}
	if (!hate)
		return FALSE;
	if (hate == self.enemy)
		return FALSE;
	if (hate.health <= 0)
		return FALSE;
	if (hate.teams == self.teams)
		return FALSE;

	//
	// found an enemy
	//

	self.enemy = hate;
	HuntTarget ();
	return TRUE;
};


void(float dist) worm_chase =
{
	if (self.enemy)
	{
		if (self.enemy.health <= 0)
		{
			self.enemy = world;
			self.th_stand();
			return;
		}
		ChangeYaw();
	}
 	movetogoal (dist);
};

void() worm_idle =
{
	if (!droptofloor())
	{
		dprint ("Worm removed because it couldn't execute droptofloor();\n");
		remove(self);
		return;
	}

	if (!self.enemy)
	{
		self.enemyteam = "human";
		FindChase();
		if (!self.enemy)
		{
			self.enemyteam = "baeloth";
			FindChase();
		}
	}
};

void() worm_idle1	=[	$crawl1,	worm_idle2	] {worm_idle();};
void() worm_idle2	=[	$crawl2,	worm_idle3	] {worm_idle();};
void() worm_idle3	=[	$crawl3,	worm_idle4	] {worm_idle();};
void() worm_idle4	=[	$crawl4,	worm_idle5	] {worm_idle();};
void() worm_idle5	=[	$crawl5,	worm_idle6	] {worm_idle();};
void() worm_idle6	=[	$crawl6,	worm_idle7	] {worm_idle();};
void() worm_idle7	=[	$crawl7,	worm_idle8	] {worm_idle();};
void() worm_idle8	=[	$crawl8,	worm_idle9	] {worm_idle();};
void() worm_idle9	=[	$crawl9,	worm_idle10	] {worm_idle();};
void() worm_idle10	=[	$crawl10,	worm_idle1	] {worm_idle();};

void() worm_melee =
{
	local	vector	source, org;

	makevectors (self.angles);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*45, FALSE, self);
	if (trace_fraction == 1.0) return;

	org = trace_endpos - v_forward*4;

	if (trace_ent.teams == "robot")
		return;

	if (trace_ent.takedamage && trace_ent.teams != self.teams)
	{
		if (self.lock_finished < time)
		{
			T_Damage (trace_ent, self, self, 2+random()*2);
			self.lock_finished = time + 1;
		}
	}
};

void() worm_crawl1	=[	$crawl1,	worm_crawl2	] 
{
	if (self.voice_finished < time)
	{
		sound (self, CHAN_BODY, "worm/squish2.wav", 1, ATTN_NORM);
		self.voice_finished = time + 3;
	}
	worm_chase(5);
	worm_melee();
};
void() worm_crawl2	=[	$crawl2,	worm_crawl3	] {worm_chase(5);worm_melee();};
void() worm_crawl3	=[	$crawl3,	worm_crawl4	] {worm_chase(5);worm_melee();};
void() worm_crawl4	=[	$crawl4,	worm_crawl5	] {worm_chase(5);worm_melee();};
void() worm_crawl5	=[	$crawl5,	worm_crawl6	] {worm_chase(5);worm_melee();};
void() worm_crawl6	=[	$crawl6,	worm_crawl7	] {worm_chase(5);worm_melee();};
void() worm_crawl7	=[	$crawl7,	worm_crawl8	] {worm_chase(5);worm_melee();};
void() worm_crawl8	=[	$crawl8,	worm_crawl9	] {worm_chase(5);worm_melee();};
void() worm_crawl9	=[	$crawl9,	worm_crawl10] {worm_chase(5);worm_melee();};
void() worm_crawl10	=[	$crawl9,	worm_crawl1	] {worm_chase(5);worm_melee();};

void() worm_death1	=[	$squished1,	worm_death1] {};

void() worm_touch =
{
	if (other.takedamage && other.teams != self.teams)
	{
		// stepped on
		droptofloor();
		particle (self.origin, '0 0 0', 59, 6); // green particle
		sound (self, CHAN_BODY, "worm/squish.wav", 1, ATTN_NORM);
		T_Damage (self, self, self, 1);
		self.angles_y = self.angles_y + (crandom()*360);
	}
};

void() monster_worm =
{
	precache_model ("progs/worm.mdl");
	precache_sound ("worm/squish.wav");
	precache_sound ("worm/squish2.wav");

	self.health = 1;
	self.takedamage = DAMAGE_NO;
	self.movetype = MOVETYPE_STEP;
	self.solid = SOLID_TRIGGER;
	self.th_stand = worm_idle1;
	self.th_run = worm_crawl1;
	self.th_die = worm_death1;
	self.classname = "worm";
	self.teams = "envenom";
	self.touch = worm_touch;
	setmodel (self, "progs/worm.mdl");
	setsize (self, '0 0 0', '0 0 0');
	monster_start();
};

// called by zombies death to release worms
void() worm_spawn =
{
	local entity worm;

	worm = spawn();
	worm.health = 1;
	worm.takedamage = DAMAGE_AIM;
	worm.movetype = MOVETYPE_STEP;
	worm.solid = SOLID_TRIGGER;
	worm.th_stand = worm_idle1;
	worm.th_run = worm_crawl1;
	worm.th_die = worm_death1;
	worm.classname = "worm";
	worm.teams = "envenom";
	worm.touch = worm_touch;
	setmodel (worm, "progs/worm.mdl");
	setsize (worm, '0 0 0', '0 0 0');
	setorigin (worm, self.origin + v_up);
	worm.think = monster_start;
	worm.nextthink = time + 0.1;
};