$frame run1 run2 run3 run4 run5 run6 run7

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9 stand10
$frame stand11 stand12 stand13 stand14 stand15 stand16 stand17 stand18 stand19 stand20
$frame stand21 stand22 stand23 stand24 stand25 stand26 stand27 stand28 stand29 stand30
$frame stand31 stand32

$frame smack1 smack2 smack3 smack4 smack5 smack6 smack7 smack8 smack9 smack10 smack11

$frame headb1 headb2 headb3 headb4 headb5 headb6 headb7

$frame paina1 paina2 paina3 paina4 paina5 paina6

$frame painb1 painb2 painb3 painb4 painb5

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9 death10 death11 death12

//
.float isup;

void() zombie_idle1	=[	$stand1,	zombie_idle2	] 
{
	ai_stand();
	if (random() < 0.1 && self.voice_finished < time)
	{
		if (random() < 0.5)
			playsound (self, CHAN_VOICE, "zombie/idle1.wav", 1, ATTN_IDLE);
		else
			playsound (self, CHAN_VOICE, "zombie/idle2.wav", 1, ATTN_IDLE);
		self.voice_finished = time + 3;
	}
};
void() zombie_idle2	=[	$stand2,	zombie_idle3	] {ai_stand();};
void() zombie_idle3	=[	$stand3,	zombie_idle4	] {ai_stand();};
void() zombie_idle4	=[	$stand4,	zombie_idle5	] {ai_stand();};
void() zombie_idle5	=[	$stand5,	zombie_idle6	] {ai_stand();};
void() zombie_idle6	=[	$stand6,	zombie_idle7	] {ai_stand();};
void() zombie_idle7	=[	$stand7,	zombie_idle8	] {ai_stand();};
void() zombie_idle8	=[	$stand8,	zombie_idle9	] {ai_stand();};
void() zombie_idle9	=[	$stand9,	zombie_idle10	] {ai_stand();};
void() zombie_idle10	=[	$stand10,	zombie_idle11	] {ai_stand();};
void() zombie_idle11	=[	$stand11,	zombie_idle12	] {ai_stand();};
void() zombie_idle12	=[	$stand12,	zombie_idle13	] {ai_stand();};
void() zombie_idle13	=[	$stand13,	zombie_idle14	] {ai_stand();};
void() zombie_idle14	=[	$stand14,	zombie_idle15	] {ai_stand();};
void() zombie_idle15	=[	$stand15,	zombie_idle16	] {ai_stand();};
void() zombie_idle16	=[	$stand16,	zombie_idle17	] {ai_stand();};
void() zombie_idle17	=[	$stand17,	zombie_idle18	] {ai_stand();};
void() zombie_idle18	=[	$stand18,	zombie_idle19	] {ai_stand();};
void() zombie_idle19	=[	$stand19,	zombie_idle20	] {ai_stand();};
void() zombie_idle20	=[	$stand20,	zombie_idle21	] {ai_stand();};
void() zombie_idle21	=[	$stand21,	zombie_idle22	] {ai_stand();};
void() zombie_idle22	=[	$stand22,	zombie_idle23	] {ai_stand();};
void() zombie_idle23	=[	$stand23,	zombie_idle24	] {ai_stand();};
void() zombie_idle24	=[	$stand24,	zombie_idle25	] {ai_stand();};
void() zombie_idle25	=[	$stand25,	zombie_idle26	] {ai_stand();};
void() zombie_idle26	=[	$stand26,	zombie_idle27	] {ai_stand();};
void() zombie_idle27	=[	$stand27,	zombie_idle28	] {ai_stand();};
void() zombie_idle28	=[	$stand28,	zombie_idle29	] {ai_stand();};
void() zombie_idle29	=[	$stand29,	zombie_idle30	] {ai_stand();};
void() zombie_idle30	=[	$stand30,	zombie_idle31	] {ai_stand();};
void() zombie_idle31	=[	$stand31,	zombie_idle32	] {ai_stand();};
void() zombie_idle32	=[	$stand32,	zombie_idle1	] {ai_stand();};

void() zombie_run1	=[	$run1,	zombie_run2	] 
{
	self.isup = TRUE;
	ai_run(5);
	if (random() < 0.1 && self.voice_finished < time)
	{
		if (random() < 0.50)
			playsound (self, CHAN_VOICE, "zombie/idle1.wav", 1, ATTN_NORM);
		else
			playsound (self, CHAN_VOICE, "zombie/idle2.wav", 1, ATTN_NORM);
		self.voice_finished = time + 3;
	}
	playsound (self, CHAN_BODY, "zombie/step.wav", 1, ATTN_NORM);
};
void() zombie_run2	=[	$run2,	zombie_run3	] {ai_run(self.speed);};
void() zombie_run3	=[	$run3,	zombie_run4	] {ai_run(self.speed);};
void() zombie_run4	=[	$run4,	zombie_run5	] {ai_run(self.speed);};
void() zombie_run5	=[	$run5,	zombie_run6	] 
{ai_run(self.speed);playsound (self, CHAN_BODY, "zombie/step.wav", 1, ATTN_NORM);};
void() zombie_run6	=[	$run6,	zombie_run7	] {ai_run(self.speed);};
void() zombie_run7	=[	$run7,	zombie_run1	] {ai_run(self.speed);};

void() zombie_paina1	=[	$paina1,	zombie_paina2	] {};
void() zombie_paina2	=[	$paina2,	zombie_paina3	] {};
void() zombie_paina3	=[	$paina3,	zombie_paina4	] {};
void() zombie_paina4	=[	$paina4,	zombie_paina5	] {};
void() zombie_paina5	=[	$paina5,	zombie_paina6	] {};
void() zombie_paina6	=[	$paina6,	zombie_run1		] {};

void() zombie_painb1	=[	$painb1,	zombie_painb2	] {};
void() zombie_painb2	=[	$painb2,	zombie_painb3	] {};
void() zombie_painb3	=[	$painb3,	zombie_painb4	] {};
void() zombie_painb4	=[	$painb4,	zombie_painb5	] {};
void() zombie_painb5	=[	$painb5,	zombie_run1		] {};

void(float dm) ExplodeHead =
{
	local	entity new;

	new = spawn();
	setorigin (new, self.origin + v_up * 24);
	setmodel (new, "progs/zmbiegib.mdl");
	setsize (new, '0 0 0', '0 0 0');
	new.velocity = VelocityForDamage(dm);
	new.movetype = MOVETYPE_TOSS;
	new.solid = SOLID_NOT;
	new.avelocity_x = random()*600;
	new.avelocity_y = random()*600;
	new.avelocity_z = random()*600;
	new.think = SUB_Remove;
	new.nextthink = time + 3;
};


void() zombie_pain =
{
	local float r;
	r = random();

	if (self.isup == FALSE) // if true, zombie hasn't fully got back on his feet
		return;

	if (self.bullettype == 0)
	{
		if (r < 0.20 && self.cnt > 0) // Corporal is able to blow off zombies heads 20% of the time,
		{					// yet only after making them fall down atleast once
			ExplodeHead (-50);
			ExplodeHead (-50);
			ExplodeHead (-50);
			ExplodeHead (-50);
			ExplodeHead (-50);
			setmodel (self, "progs/nhzombie.mdl");
			setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
			self.cnt = 0;
			self.th_die = nhzombie_death1;
			self.th_run = nhzombie_run1;
			self.th_pain = SUB_Null;
			self.th_melee = SUB_Null;
			self.th_run();
			playsound (self, CHAN_AUTO, "zombie/splat.wav", 1, ATTN_NORM);
			return;
		}
	}

	if (self.pain_finished > time || self.zombie_onground == TRUE)
		return;

	if (r < 0.25) // allow sounds to come through over non-flinch
		self.noise = "zombie/pain1.wav";
	else if (r < 0.50)
		self.noise = "zombie/pain2.wav";
	else if (r < 0.75)
		self.noise = "zombie/pain3.wav";
	else
		self.noise = "zombie/pain4.wav";

	if (random() < 0.70) // don't flinch all the time
		return;

	if (random() < 0.50)
	{
		self.pain_finished = time + 0.7;
		zombie_paina1();
	}
	else
	{
		self.pain_finished = time + 0.6;
		zombie_painb1();
	}

	playsound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
};

void() zombie_getup1;
void() zombie_fakedeath1	=[	$death11,	zombie_fakedeath2	] {};
void() zombie_fakedeath2	=[	$death12,	zombie_fakedeath3	] 
{
	self.isup = FALSE;
	self.nextthink = time + random() * 3;
};
void() zombie_fakedeath3	=[	$death12,	zombie_getup1	] 
{
	// see if ok to stand up
	self.health = 32;
	self.zombie_onground = TRUE;
	self.solid = SOLID_SLIDEBOX;
	if (!walkmove (0, 0))
	{
		self.think = zombie_fakedeath2;
		self.solid = SOLID_NOT;
		return;
	}
};

void() zombie_death1	=[	$death1,	zombie_death2	] 
{
	self.solid = SOLID_NOT;
	playsound (self, CHAN_VOICE, "zombie/death.wav", 1, ATTN_NORM);
};
void() zombie_death2	=[	$death2,	zombie_death3	] {};
void() zombie_death3	=[	$death3,	zombie_death4	] {};
void() zombie_death4	=[	$death4,	zombie_death5	] {};
void() zombie_death5	=[	$death5,	zombie_death6	] {};
void() zombie_death6	=[	$death6,	zombie_death7	] {};
void() zombie_death7	=[	$death7,	zombie_death8	] {};
void() zombie_death8	=[	$death8,	zombie_death9	] {};
void() zombie_death9	=[	$death9,	zombie_death10	] {};
void() zombie_death10	=[	$death10,	zombie_death11	] 
{
	playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);
	if (random() < 0.5) // zombie falls yet doesn't die
	{
		if (self.cnt < 2) // can get back up 2 times
		{
			self.cnt = self.cnt + 1;
			zombie_fakedeath1();
		}
	}
};

void() zombie_death11	=[	$death11,	zombie_death12	] 
{
	if (self.zombie_onground)
	{
		self.solid = SOLID_NOT;
		playsound (self, CHAN_VOICE, "zombie/death.wav", 1, ATTN_NORM);
	}
	blood(25,0,5); // f,s,sz
};
void() zombie_death12	=[	$death12,	zombie_death12	] 
{
	local float r;

	self.keyflags = random()*3;
	if (self.cnt < self.keyflags)
	{
		worm_spawn();
		self.cnt = self.cnt + 1;
		self.nextthink = self.nextthink + 0.2 + random()*1.2;
	}
	if (self.walkframe == 0) // play "worm crawling out of host" sound
	{
		if (self.keyflags > 0)
			sound (self, CHAN_VOICE, "worm/squish2.wav", 1, ATTN_NORM);
		self.walkframe = 1;

	}
};

void() zombie_death =
{
	if (self.isup == TRUE)
		zombie_death1();
	else
		zombie_death11();
	self.takedamage = DAMAGE_AIM;
};

void() zombie_smack1	=[	$smack1,	zombie_smack2	] {};
void() zombie_smack2	=[	$smack2,	zombie_smack3	] {};
void() zombie_smack3	=[	$smack3,	zombie_smack4	] {};
void() zombie_smack4	=[	$smack4,	zombie_smack5	] 
{
	local	vector	source, org;

	if (!self.enemy)
		return;

	makevectors (self.angles);

	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, FALSE, self);
	if (trace_fraction == 1.0) return;
	
	org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		T_Damage (trace_ent, self, self, 9);
		playsound (self, CHAN_WEAPON, "zombie/smack.wav", 1, ATTN_NORM);
	}
};
void() zombie_smack5	=[	$smack5,	zombie_smack6	] {};
void() zombie_smack6	=[	$smack6,	zombie_smack7	] {};
void() zombie_smack7	=[	$smack7,	zombie_smack8	] 
{
	local	vector	source, org;

	if (!self.enemy)
		return;

	makevectors (self.angles);

	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, FALSE, self);
	if (trace_fraction == 1.0) return;
	
	org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		T_Damage (trace_ent, self, self, 6);
		playsound (self, CHAN_WEAPON, "zombie/smack.wav", 1, ATTN_NORM);
	}
};
void() zombie_smack8	=[	$smack8,	zombie_smack9	] {};
void() zombie_smack9	=[	$smack9,	zombie_smack10	] {};
void() zombie_smack10	=[	$smack10,	zombie_smack11	] {};
void() zombie_smack11	=[	$smack11,	zombie_run1		] {};

void() zombie_headb1	=[	$headb1,	zombie_headb2	] {};
void() zombie_headb2	=[	$headb2,	zombie_headb3	] {};
void() zombie_headb3	=[	$headb3,	zombie_headb4	] {};
void() zombie_headb4	=[	$headb4,	zombie_headb5	] 
{
	local	vector	source, org;

	if (!self.enemy)
		return;

	makevectors (self.angles);

	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, FALSE, self);
	if (trace_fraction == 1.0) return;
	
	org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		T_Damage (trace_ent, self, self, 10);
		playsound (self, CHAN_WEAPON, "zombie/smack.wav", 1, ATTN_NORM);
	}
};

void() zombie_headb5	=[	$headb5,	zombie_headb6	] {};
void() zombie_headb6	=[	$headb6,	zombie_headb7	] {};
void() zombie_headb7	=[	$headb7,	zombie_run1		] {};

void() zombie_attack =
{
	ai_face();
	if (random() < 0.40)
		zombie_headb1();
	else
		zombie_smack1();
	self.hostile_finished = time + 1;
};

// grounded
void() zombie_grounded	=[	$death12,	zombie_grounded	]
{
	if (self.zombie_onground == TRUE)
		ai_stand(); // all seeing eye
};

void() zombie_getupcheck = // called by zombies who spawn with face on floor
{
	// see if ok to stand up
	self.think = zombie_getup1;
	self.zombie_onground = TRUE;
	self.solid = SOLID_SLIDEBOX;
	self.zombie_onground = FALSE;
	if (!walkmove (0, 0))
	{
		self.isup = FALSE;
		self.think = zombie_getupcheck;
		self.solid = SOLID_NOT;
		self.zombie_onground = TRUE;
		return;
	}
	self.nextthink = time + 0.1;
};

void() zombie_getup1	=[	$death12,	zombie_getup2	] {self.solid = SOLID_SLIDEBOX;};
void() zombie_getup2	=[	$death11,	zombie_getup3	] {};
void() zombie_getup3	=[	$death10,	zombie_getup4	] {};
void() zombie_getup4	=[	$death9,	zombie_getup5	] {};
void() zombie_getup5	=[	$death8,	zombie_getup6	] {};
void() zombie_getup6	=[	$death7,	zombie_getup7	] {};
void() zombie_getup7	=[	$death6,	zombie_getup8	] {};
void() zombie_getup8	=[	$death5,	zombie_getup9	] {};
void() zombie_getup9	=[	$death4,	zombie_getup10	] {};
void() zombie_getup10	=[	$death3,	zombie_getup11	] {};
void() zombie_getup11	=[	$death2,	zombie_getup12	] {}; 
void() zombie_getup12	=[	$death1,	zombie_run1 	] 
{
	self.zombie_onground = FALSE;
	self.th_run = zombie_run1;
	self.th_stand = zombie_idle1;
};

void() monster_zombie =
{
	precache_model ("progs/zmbiegib.mdl");
	precache_model ("progs/zombie.mdl");
	precache_model ("progs/nhzombie.mdl"); // zombie lost it's head
	precache_model ("progs/worm.mdl");
	precache_sound ("zombie/death.wav");
	precache_sound ("zombie/idle1.wav");
	precache_sound ("zombie/idle2.wav");
	precache_sound ("zombie/pain1.wav");
	precache_sound ("zombie/pain2.wav");
	precache_sound ("zombie/pain3.wav");
	precache_sound ("zombie/pain4.wav");
	precache_sound ("zombie/smack.wav");
	precache_sound ("zombie/step.wav");
	precache_sound ("zombie/splat.wav");
	precache_sound ("worm/squish.wav");
	precache_sound ("worm/squish2.wav");

	self.health = self.max_health = 50;
	self.movetype = MOVETYPE_STEP;

	if (!self.zombie_onground)
	{
		self.isup = TRUE;
		self.solid = SOLID_SLIDEBOX;
		self.th_stand = zombie_idle1;
		self.th_run = zombie_run1;
	}
	else
	{
		self.isup = FALSE;
		self.solid = SOLID_NOT;
		self.th_stand = zombie_grounded;
		self.th_run = zombie_getupcheck;
	}

	self.speed = 4;
	self.th_die = zombie_death;
	self.th_pain = zombie_pain;
	self.th_melee = zombie_attack;
	self.classname = "zombie";
	self.teams = "envenom";
	setmodel (self, "progs/zombie.mdl");
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	monster_start();
};