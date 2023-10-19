$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9 stand10 stand11 stand12 stand13 stand14 stand15 stand16
$frame stand17

$frame run1 run2 run3 run4 run5 run6 run7 run8 run9 run10 run11 run12 run13 run14 run15

$frame jump1 jump2 jump3 jump4 jump5 jump6 jump7 jump8 jump9 jump10 jump11 jump12 jump13 jump14 jump15 jump16

$frame attk1 attk2 attk3 attk4 attk5 attk6 attk7 attk8 attk9 attk10 attk11

$frame maul1 maul2 maul3 maul4 maul5 maul6 maul7 maul8 maul9 maul10 maul11 maul12 maul13

$frame look1 look2 look3 look4 look5 look6 look7 look8 look9 look10

$frame pain1 pain2 pain3 pain4

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9 death10 death11 death12

$frame flip1 flip2 flip3 flip4 flip5 flip6 flip7 flip8

$frame lunge1 lunge2 lunge3 lunge4 lunge5 lunge6 lunge7 lunge8 lunge9 lunge10 lunge11

$frame roofhide1 roofhide2 roofhide3 roofhide4 roofhide5 roofhide6

//

void() vile_idle1	=[	$stand1,	vile_idle2	] 
{
	local float r;
	if (random() < 0.3 && self.voice_finished < time)
	{
		r = random();
		if (r < 0.25)
			playsound (self, CHAN_VOICE, "vile/idle1.wav", 1, ATTN_IDLE);
		else if (r < 0.50)
			playsound (self, CHAN_VOICE, "vile/idle2.wav", 1, ATTN_IDLE);
		else if (r < 0.75)
			playsound (self, CHAN_VOICE, "vile/idle3.wav", 1, ATTN_IDLE);
		else
			playsound (self, CHAN_VOICE, "vile/idle4.wav", 1, ATTN_IDLE);
		self.voice_finished = time + 3;
	}
	ai_stand();
};

void() vile_idle2	=[	$stand2,	vile_idle3	] {ai_stand();};
void() vile_idle3	=[	$stand3,	vile_idle4	] {ai_stand();};
void() vile_idle4	=[	$stand4,	vile_idle5	] {ai_stand();};
void() vile_idle5	=[	$stand5,	vile_idle6	] {ai_stand();};
void() vile_idle6	=[	$stand6,	vile_idle7	] {ai_stand();};
void() vile_idle7	=[	$stand7,	vile_idle8	] {ai_stand();};
void() vile_idle8	=[	$stand8,	vile_idle9	] {ai_stand();};
void() vile_idle9	=[	$stand9,	vile_idle10	] {ai_stand();};
void() vile_idle10	=[	$stand10,	vile_idle11	] {ai_stand();};
void() vile_idle11	=[	$stand11,	vile_idle12	] {ai_stand();};
void() vile_idle12	=[	$stand12,	vile_idle13	] {ai_stand();};
void() vile_idle13	=[	$stand13,	vile_idle14	] {ai_stand();};
void() vile_idle14	=[	$stand14,	vile_idle15	] {ai_stand();};
void() vile_idle15	=[	$stand15,	vile_idle16	] {ai_stand();};
void() vile_idle16	=[	$stand16,	vile_idle17	] {ai_stand();};
void() vile_idle17	=[	$stand17,	vile_idle1	] {ai_stand();};

void() vile_run1;
void() vile_look1	=[	$look1,	vile_look2	] {};
void() vile_look2	=[	$look2,	vile_look3	] {};
void() vile_look3	=[	$look3,	vile_look4	] {};
void() vile_look4	=[	$look4,	vile_look5	] {};
void() vile_look5	=[	$look5,	vile_look6	] {};
void() vile_look6	=[	$look6,	vile_look7	] {};
void() vile_look7	=[	$look7,	vile_look8	] {};
void() vile_look8	=[	$look8,	vile_look9	] {};
void() vile_look9	=[	$look9,	vile_look10	] {};
void() vile_look10	=[	$look10,	vile_run11	] {};

void() vile_run1	=[	$run1,	vile_run2	] 
{
	if (!infront(self.enemy))
	{
		if (random() < 0.40)
			vile_look1();
	}
	ai_run(self.speed);
};
void() vile_run2	=[	$run2,	vile_run3	] {ai_run(self.speed);};
void() vile_run3	=[	$run3,	vile_run4	] {ai_run(self.speed);};
void() vile_run4	=[	$run4,	vile_run5	] {ai_run(self.speed);};
void() vile_run5	=[	$run5,	vile_run6	] {ai_run(self.speed);};
void() vile_run6	=[	$run6,	vile_run7	] {ai_run(self.speed);};
void() vile_run7	=[	$run7,	vile_run8	] {ai_run(self.speed);};
void() vile_run8	=[	$run8,	vile_run9	] {ai_run(self.speed);};
void() vile_run9	=[	$run9,	vile_run10	] {};
void() vile_run10	=[	$run10,	vile_run11	] {ai_run(self.speed);};
void() vile_run11	=[	$run11,	vile_run12	] {ai_run(self.speed);};
void() vile_run12	=[	$run12,	vile_run13	] {ai_run(self.speed);};
void() vile_run13	=[	$run13,	vile_run14	] {ai_run(self.speed);};
void() vile_run14	=[	$run14,	vile_run15	] {};
void() vile_run15	=[	$run15,	vile_run1	] {ai_run(self.speed);};

void() VileJumpTouch =
{
	local	float	damg;

	if (self.health <= 0)
		return;

	if (other.takedamage)
	{
		if (vlen(self.velocity) > 400)
		{
			damg = 10 + 6*random();
			T_Damage (other, self, self, damg);
			self.touch = SUB_Null;
		}
	}
};

void() vile_jump1	=[	$jump1,	vile_jump2	] 
{
	self.hostile_finished = time + 1;
	ai_face();
};
void() vile_jump2	=[	$jump2,	vile_jump3	] {ai_face();};
void() vile_jump3	=[	$jump3,	vile_jump4	] {ai_face();};
void() vile_jump4	=[	$jump4,	vile_jump5	] 
{
	ai_face();
	playsound (self, CHAN_VOICE, "vile/leap.wav", 1, ATTN_NORM);
	makevectors (self.angles);
	self.touch = VileJumpTouch;
	self.origin_z = self.origin_z + 1;
	self.velocity = v_forward * 300 + '0 0 200';
	if (self.flags & FL_ONGROUND)
		self.flags = self.flags - FL_ONGROUND;
};
void() vile_jump5	=[	$jump5,	vile_jump6	] {};
void() vile_jump6	=[	$jump6,	vile_jump7	] {};
void() vile_jump7	=[	$jump7,	vile_jump8	] {};
void() vile_jump8	=[	$jump8,	vile_jump9	] {};
void() vile_jump9	=[	$jump9,	vile_jump10	] {};
void() vile_jump10	=[	$jump10,	vile_jump11	] {};

void() vile_jump12;
void() vile_jump11	=[	$jump11,	vile_jump11	] 
{
	if (self.flags & FL_ONGROUND)
	{
		// TODO: Add land sound
		vile_jump12(); // land it
		self.touch = SUB_Null;
	}
};

void() vile_jump12	=[	$jump12,	vile_jump13	] {};
void() vile_jump13	=[	$jump13,	vile_jump14	] {};
void() vile_jump14	=[	$jump14,	vile_jump15	] {};
void() vile_jump15	=[	$jump15,	vile_jump16	] {};
void() vile_jump16	=[	$jump16,	vile_run1	] {}; // TODO: Finish vile's jump

void() vile_atk1	=[	$attk1,	vile_atk2	] {};
void() vile_atk2	=[	$attk2,	vile_atk3	] {};
void() vile_atk3	=[	$attk3,	vile_atk4	] {};
void() vile_atk4	=[	$attk4,	vile_atk5	] {};
void() vile_atk5	=[	$attk5,	vile_atk6	] {};
void() vile_atk6	=[	$attk6,	vile_atk7	] 
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
		T_Damage (trace_ent, self, self, 8);
		sound (self, CHAN_WEAPON, "demon/dhit2.wav", 1, ATTN_NORM);
	}
};
void() vile_atk7	=[	$attk7,	vile_atk8	] {};
void() vile_atk8	=[	$attk8,	vile_atk9	] {};
void() vile_atk9	=[	$attk9,	vile_atk10	] {};
void() vile_atk10	=[	$attk10,	vile_atk11	] {};
void() vile_atk11	=[	$attk11,	vile_run1	] {};

void() vile_maul1	=[	$maul1,	vile_maul2	] {};
void() vile_maul2	=[	$maul2,	vile_maul3	] {};
void() vile_maul3	=[	$maul3,	vile_maul4	] 
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
		sound (self, CHAN_WEAPON, "demon/dhit2.wav", 1, ATTN_NORM);
	}
};
void() vile_maul4	=[	$maul4,	vile_maul5	] {};
void() vile_maul5	=[	$maul5,	vile_maul6	] {};
void() vile_maul6	=[	$maul6,	vile_maul7	] {};
void() vile_maul7	=[	$maul7,	vile_maul8	] {};
void() vile_maul8	=[	$maul8,	vile_maul9	] 
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
		sound (self, CHAN_WEAPON, "demon/dhit2.wav", 1, ATTN_NORM);
	}
};
void() vile_maul9	=[	$maul9,	vile_maul10	] {};
void() vile_maul10	=[	$maul10,	vile_maul11	] {};
void() vile_maul11	=[	$maul11,	vile_maul12	] {};
void() vile_maul12	=[	$maul12,	vile_maul13	] {};
void() vile_maul13	=[	$maul13,	vile_run1	] {};

//decapitation attack
void() vile_lunge1	=[	$lunge1,	vile_lunge2	] {};
void() vile_lunge2	=[	$lunge2,	vile_lunge3	] {};
void() vile_lunge3	=[	$lunge3,	vile_lunge4	] {};
void() vile_lunge4	=[	$lunge4,	vile_lunge5	] {};
void() vile_lunge5	=[	$lunge5,	vile_lunge6	] {};
void() vile_lunge6	=[	$lunge6,	vile_lunge7	] {};
void() vile_lunge7	=[	$lunge7,	vile_lunge8	] {};
void() vile_lunge8	=[	$lunge8,	vile_lunge9	] 
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
		trace_ent.deathtype = 1;
		T_Damage (trace_ent, self, self, 999); // instant death
	}
};
void() vile_lunge9	=[	$lunge9,	vile_lunge10	] {};
void() vile_lunge10	=[	$lunge10,	vile_lunge11	] {};
void() vile_lunge11	=[	$lunge11,	vile_run1	] {};

void() vile_attack =
{
	local float r, r2;

	ai_face();
	self.hostile_finished = time + 1;

	r = random();
	if (r < 0.35 && self.enemy.health < 40)
		vile_lunge1();
	else if (r < 0.60)
		vile_maul1();
	else
		vile_atk1();

	r2 = rint ((random() * 1) + 1);
	if (r2 == 1)
		self.noise = "vile/attack.wav";
	if (r2 == 2)
		self.noise = "vile/attack2.wav";

	playsound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);		
};

void() vile_pain1	=[	$pain1,	vile_pain2	] {};
void() vile_pain2	=[	$pain2,	vile_pain3	] {};
void() vile_pain3	=[	$pain3,	vile_pain4	] {};
void() vile_pain4	=[	$pain4,	vile_run1	] {};

void() vile_pain =
{
	local float r;
	r = random();

	if (self.pain_finished > time)
		return;

	r = rint ((random() * 2) + 1);
	if (r == 1)
		self.noise = "vile/pain1.wav";
	if (r == 2)
		self.noise = "vile/pain2.wav";
	if (r == 3)
		self.noise = "vile/pain3.wav";
	playsound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);

	if (random() < 0.90) // hardly flinches
		return;
	vile_pain1();
};

void() vile_death1 =[	$death1,	vile_death2	] {self.solid = SOLID_NOT;};
void() vile_death2 =[	$death2,	vile_death3	] {};
void() vile_death3 =[	$death3,	vile_death4	] {};
void() vile_death4 =[	$death4,	vile_death5	] 
{
	blood(0,3,6); // f,s,sz
	playsound (self, CHAN_BODY, "misc/florhit.wav", 0.5, ATTN_NORM); // soft hit
};
void() vile_death5 =[	$death5,	vile_death6	] {};
void() vile_death6 =[	$death6,	vile_death7	] {};
void() vile_death7 =[	$death7,	vile_death8	] {};
void() vile_death8 =[	$death8,	vile_death9	] {};
void() vile_death9 =[	$death9,	vile_death10	] {};
void() vile_death10 =[	$death10,	vile_death11	] 
{
	playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);
};
void() vile_death11 =[	$death11,	vile_death12	] {};
void() vile_death12 =[	$death12,	vile_death12		] {};

// Hard hitting deaths cause the vile to flip
void() vile_flip1 =[	$flip1,	vile_flip2 ] 
{
	self.solid = SOLID_NOT;
	blood(0,3,6); // f,s,sz
};
void() vile_flip2 =[	$flip2,	vile_flip3 ] {};
void() vile_flip3 =[	$flip3,	vile_flip4 ] {};
void() vile_flip4 =[	$flip4,	vile_flip5 ] {};
void() vile_flip5 =[	$flip5,	vile_flip6 ] {};
void() vile_flip6 =[	$flip6,	vile_flip7 ] {};
void() vile_flip7 =[	$flip7,	vile_flip8 ] 
{
	playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);
};
void() vile_flip8 =[	$flip8,	vile_flip8 ] {};

void() vile_death =
{
	local float r;

	r = rint ((random() * 1) + 1);
	if (r == 1)
		self.noise = "vile/death1.wav";
	if (r == 2)
		self.noise = "vile/death2.wav";

	playsound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);

	if (random() < 0.50)
		vile_flip1();
	else
		vile_death1();
	return;
};

void() monster_vile =
{
	precache_model ("progs/vile.mdl");

	precache_sound ("demon/dhit2.wav"); // change me!
	precache_sound ("vile/idle1.wav");
	precache_sound ("vile/idle2.wav");
	precache_sound ("vile/idle3.wav");
	precache_sound ("vile/idle4.wav");
	precache_sound ("vile/attack.wav");
	precache_sound ("vile/attack2.wav");
	precache_sound ("vile/leap.wav");
	precache_sound ("vile/pain1.wav");
	precache_sound ("vile/pain2.wav");
	precache_sound ("vile/pain3.wav");
	precache_sound ("vile/death1.wav");
	precache_sound ("vile/death2.wav");

	self.health = self.max_health = 235;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	self.th_stand = vile_idle1;
	self.th_run = vile_run1;
	self.th_die = vile_death;
	self.th_pain = vile_pain;
	self.th_melee = vile_attack;
	self.th_missile = vile_jump1;
	self.classname = "vile";
	self.teams = "envenom";
	self.speed = 11;

	setmodel (self, "progs/vile.mdl");
	setsize (self, '-12 -18 -24', '17 18 18');
	monster_start();
};