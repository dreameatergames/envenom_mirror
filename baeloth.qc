$frame death1 death2 death3 death4 death5 death6

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8 deathb9 deathb10 deathb11

$frame pain1 pain2 pain3 pain4 pain5

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7

$frame idle1 idle2 idle3 idle4 idle5 idle6 idle7 idle8 idle9 idle10 idle11 idle12

$frame reload1 reload2 reload3 reload4 reload5 reload6 reload7 reload8 reload9 reload10 reload11 reload12 reload13 reload14
$frame reload15

$frame attack1 attack2 attack3 attack4 attack5

$frame attackb1 attackb2

$frame run1 run2 run3 run4 run5 run6 run7 run8 run9 run10 run11 run12

$frame leftstrafe1 leftstrafe2 leftstrafe3 leftstrafe4 leftstrafe5

$frame rightstrafe1 rightstrafe2 rightstrafe3 rightstrafe4 rightstrafe5

//

void() baeloth_idle1;

void() baeloth_idle1	=[	$idle1,	baeloth_idle2	] {ai_stand();};
void() baeloth_idle2	=[	$idle2,	baeloth_idle2	] {ai_stand();};
void() baeloth_idle3	=[	$idle3,	baeloth_idle3	] {ai_stand();};
void() baeloth_idle4	=[	$idle4,	baeloth_idle4	] {ai_stand();};
void() baeloth_idle5	=[	$idle5,	baeloth_idle5	] {ai_stand();};
void() baeloth_idle6	=[	$idle6,	baeloth_idle6	] {ai_stand();};
void() baeloth_idle7	=[	$idle7,	baeloth_idle7	] {ai_stand();};
void() baeloth_idle8	=[	$idle8,	baeloth_idle8	] {ai_stand();};
void() baeloth_idle9	=[	$idle9,	baeloth_idle9	] {ai_stand();};
void() baeloth_idle10	=[	$idle10,	baeloth_idle10	] {ai_stand();};
void() baeloth_idle11	=[	$idle11,	baeloth_idle11	] {ai_stand();};
void() baeloth_idle12	=[	$idle11,	baeloth_idle1	] {ai_stand();};

void() baeloth_run1	=[	$run1,	baeloth_run2	] {ai_run(self.speed);};
void() baeloth_run2	=[	$run2,	baeloth_run3	] 
{
	ai_run(self.speed);
	playsound (self, CHAN_BODY, "baeloth/walk.wav", 1, ATTN_NORM);
};
void() baeloth_run3	=[	$run3,	baeloth_run4	] {ai_run(self.speed);};
void() baeloth_run4	=[	$run4,	baeloth_run5	] {ai_run(self.speed);};
void() baeloth_run5	=[	$run5,	baeloth_run6	] {ai_run(self.speed);};
void() baeloth_run6	=[	$run6,	baeloth_run7	] {ai_run(self.speed);};
void() baeloth_run7	=[	$run7,	baeloth_run8	] 
{
	ai_run(3);
	playsound (self, CHAN_BODY, "baeloth/walk.wav", 1, ATTN_NORM);
};
void() baeloth_run8	=[	$run8,	baeloth_run9	] {ai_run(self.speed);};
void() baeloth_run9	=[	$run9,	baeloth_run10	] {ai_run(self.speed);};
void() baeloth_run10	=[	$run10,	baeloth_run11	] {ai_run(self.speed);};
void() baeloth_run11	=[	$run11,	baeloth_run12	] {ai_run(self.speed);};
void() baeloth_run12	=[	$run12,	baeloth_run1	] {ai_run(self.speed);};

void() baeloth_strafeleft1	=[	$leftstrafe1,	baeloth_strafeleft2	] {};
void() baeloth_strafeleft2	=[	$leftstrafe2,	baeloth_strafeleft3	] {};
void() baeloth_strafeleft3	=[	$leftstrafe3,	baeloth_strafeleft4	] {};
void() baeloth_strafeleft4	=[	$leftstrafe4,	baeloth_strafeleft5	] {};
void() baeloth_strafeleft5	=[	$leftstrafe5,	baeloth_run1	] {};

void() baeloth_straferight1	=[	$rightstrafe1,	baeloth_straferight2	] {};
void() baeloth_straferight2	=[	$rightstrafe2,	baeloth_straferight3	] {};
void() baeloth_straferight3	=[	$rightstrafe3,	baeloth_straferight4	] {};
void() baeloth_straferight4	=[	$rightstrafe4,	baeloth_straferight5	] {};
void() baeloth_straferight5	=[	$rightstrafe5,	baeloth_run1	] {};

void() baeloth_pain1	=[	$pain1,	baeloth_pain2	] {};
void() baeloth_pain2	=[	$pain2,	baeloth_pain3	] {};
void() baeloth_pain3	=[	$pain3,	baeloth_pain4	] {};
void() baeloth_pain4	=[	$pain4,	baeloth_pain5	] {};
void() baeloth_pain5	=[	$pain5,	baeloth_run1	] {};

void() baeloth_painb1	=[	$painb1,	baeloth_painb2	] {};
void() baeloth_painb2	=[	$painb2,	baeloth_painb3	] {};
void() baeloth_painb3	=[	$painb3,	baeloth_painb4	] {};
void() baeloth_painb4	=[	$painb4,	baeloth_painb5	] {};
void() baeloth_painb5	=[	$painb5,	baeloth_painb6	] {};
void() baeloth_painb6	=[	$painb6,	baeloth_painb7	] {};
void() baeloth_painb7	=[	$painb7,	baeloth_run1	] {};

void() baeloth_pain =
{
	local float r;
	r = random();

	if (self.pain_finished > time)
		return;

	playsound (self, CHAN_VOICE, "baeloth/pain.wav", 1, ATTN_NORM);

	if (random() < 0.65) // flinch
		return;

	if (random() < 0.50)
	{
		self.pain_finished = time + 0.6;
		baeloth_pain1();
	}
	else
	{
		self.pain_finished = time + 0.8;
		baeloth_painb1();
	}
};

void() baeloth_death1	=[	$death1,	baeloth_death2	] {self.solid = SOLID_NOT;};
void() baeloth_death2	=[	$death2,	baeloth_death3	] {};
void() baeloth_death3	=[	$death3,	baeloth_death4	] {};
void() baeloth_death4	=[	$death4,	baeloth_death5	] {};
void() baeloth_death5	=[	$death5,	baeloth_death6	] 
{
	playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);
	blood(0,1,4); // f,s,sz
};
void() baeloth_death6	=[	$death6,	baeloth_death6	] {};

void() baeloth_deathb1	=[	$deathb1,	baeloth_deathb2	] {self.solid = SOLID_NOT;};
void() baeloth_deathb2	=[	$deathb2,	baeloth_deathb3	] {};
void() baeloth_deathb3	=[	$deathb3,	baeloth_deathb4	] {};
void() baeloth_deathb4	=[	$deathb4,	baeloth_deathb5	] {};
void() baeloth_deathb5	=[	$deathb5,	baeloth_deathb6	] {};
void() baeloth_deathb6	=[	$deathb6,	baeloth_deathb7	] {};
void() baeloth_deathb7	=[	$deathb7,	baeloth_deathb8	] {};
void() baeloth_deathb8	=[	$deathb8,	baeloth_deathb9	] {};
void() baeloth_deathb9	=[	$deathb9,	baeloth_deathb10	] {};
void() baeloth_deathb10	=[	$deathb10,	baeloth_deathb11	] 
{
	playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);
	blood(20,1,4); // f,s,sz
};
void() baeloth_deathb11	=[	$deathb11,	baeloth_deathb11	] {};

void() baeloth_decap1	=[0,		baeloth_decap2] {};
void() baeloth_decap2	=[1,		baeloth_decap3] {};
void() baeloth_decap3	=[2,		baeloth_decap4] {};
void() baeloth_decap4	=[3,		baeloth_decap5] 
{
	if (self.flags & FL_ONGROUND)
		playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);
	blood(-30,1,2);
};
void() baeloth_decap5	=[4,		baeloth_decap5] {};

void() baeloth_death =
{
	if (self.deathtype == 0)
	{
		if (random() < 0.50)
			baeloth_death1();
		else
			baeloth_deathb1();

		playsound (self, CHAN_VOICE, "baeloth/death.wav", 1, ATTN_NORM);
	}
	else if (self.deathtype == 1)
	{
		ThrowHead ("progs/h_bael.mdl", self.health);
		setmodel(self, "progs/decap2.mdl");
		setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
		baeloth_decap1();
		playsound (self, CHAN_BODY, "baeloth/decaped.wav", 1, ATTN_NORM);
	}
};

void() FireBolt =
{
	local	vector org;

	local vector	delta;

	if (!self.enemy)
		return;		// removed before stroke
		
	playsound (self, CHAN_WEAPON, "baeloth/fire.wav", 1, ATTN_NORM);
	delta = self.enemy.origin - self.origin;
	if (vlen(delta) > 60)
		return;

	ai_face();
	org = self.origin + '0 0 16' + v_right*11 + v_forward*20;
	traceline (org , org + v_forward*65, TRUE, self);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
	WriteEntity (MSG_BROADCAST, self);
	WriteCoord (MSG_BROADCAST, org_x);
	WriteCoord (MSG_BROADCAST, org_y);
	WriteCoord (MSG_BROADCAST, org_z);
	WriteCoord (MSG_BROADCAST, trace_endpos_x);
	WriteCoord (MSG_BROADCAST, trace_endpos_y);
	WriteCoord (MSG_BROADCAST, trace_endpos_z);
	LightningDamage (self.origin, trace_endpos + v_forward*4, self, 6);
};

void() baeloth_reload1	=[	$reload1,	baeloth_reload2	] {};
void() baeloth_reload2	=[	$reload2,	baeloth_reload3	] {};
void() baeloth_reload3	=[	$reload3,	baeloth_reload4	] {};
void() baeloth_reload4	=[	$reload4,	baeloth_reload5	] {};
void() baeloth_reload5	=[	$reload5,	baeloth_reload6	] {};
void() baeloth_reload6	=[	$reload6,	baeloth_reload7	] {};
void() baeloth_reload7	=[	$reload7,	baeloth_reload8	] {};
void() baeloth_reload8	=[	$reload8,	baeloth_reload9	] {};
void() baeloth_reload9	=[	$reload9,	baeloth_reload10	] {};
void() baeloth_reload10	=[	$reload10,	baeloth_reload11	] {};
void() baeloth_reload11	=[	$reload11,	baeloth_reload12	] {};
void() baeloth_reload12	=[	$reload12,	baeloth_reload13	] {};
void() baeloth_reload13	=[	$reload13,	baeloth_reload14	] {};
void() baeloth_reload14	=[	$reload14,	baeloth_reload15	] {};
void() baeloth_reload15	=[	$reload15,	baeloth_run1	] {};

void() baeloth_lit1	=[	$attackb1,	baeloth_lit2	] 
{
	if (self.lock_finished > time)
		return;
	if (self.weapon > 5)
	{
		baeloth_reload1();
		self.weapon = 0;
		return;
	}

	self.hostile_finished = time + 1;
	self.weapon = self.weapon + 1;

	FireBolt();
	self.lock_finished = time + 0.2;
};

void() baeloth_lit2	=[	$attackb1,	baeloth_run1	] {};

void() monster_baeloth =
{
	precache_model ("progs/baeloth.mdl");
	precache_model ("progs/decap2.mdl");
	precache_model ("progs/h_bael.mdl");
	precache_sound ("baeloth/fire.wav");
	precache_sound ("baeloth/walk.wav");
	precache_sound ("baeloth/pain.wav");
	precache_sound ("baeloth/death.wav");
	precache_sound ("baeloth/decaped.wav");

	self.health = self.max_health = 125;
	self.teams = "baeloth";
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.th_stand = baeloth_idle1;
	self.th_run = baeloth_run1;
	self.th_melee = baeloth_lit1;
	self.th_pain = baeloth_pain;
	self.th_die = baeloth_death;
	self.speed = 8;
	self.classname = "baeloth";
	setmodel (self, "progs/baeloth.mdl");
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	monster_start();
};