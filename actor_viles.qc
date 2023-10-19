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

// Introduction movie Vile

void() actorvile_run =
{
	local entity client;
	local float r;

	if (self.goalentity == world)
	{
		client = checkclient ();
		self.goalentity = client;
	}
	else
		movetogoal(15);

	r = range(self.goalentity);
	if (r == RANGE_CLOSE && visible(self.goalentity))
	{
		ai_quickturn();
		self.th_missile();
	}
};

void() actorvile_run1	=[	$run1,	actorvile_run2	] {actorvile_run();};
void() actorvile_run2	=[	$run2,	actorvile_run3	] {actorvile_run();};
void() actorvile_run3	=[	$run3,	actorvile_run4	] {actorvile_run();};
void() actorvile_run4	=[	$run4,	actorvile_run5	] {actorvile_run();};
void() actorvile_run5	=[	$run5,	actorvile_run6	] {actorvile_run();};
void() actorvile_run6	=[	$run6,	actorvile_run7	] {actorvile_run();};
void() actorvile_run7	=[	$run7,	actorvile_run8	] {actorvile_run();};
void() actorvile_run8	=[	$run8,	actorvile_run9	] {actorvile_run();};
void() actorvile_run9	=[	$run9,	actorvile_run10	] {actorvile_run();};
void() actorvile_run10	=[	$run10,	actorvile_run11	] {actorvile_run();};
void() actorvile_run11	=[	$run11,	actorvile_run12	] {actorvile_run();};
void() actorvile_run12	=[	$run12,	actorvile_run13	] {actorvile_run();};
void() actorvile_run13	=[	$run13,	actorvile_run14	] {actorvile_run();};
void() actorvile_run14	=[	$run14,	actorvile_run15	] {actorvile_run();};
void() actorvile_run15	=[	$run15,	actorvile_run1	] {actorvile_run();};

void() actorvile_stand =
{
	if (self.lock_finished < time)
		actorvile_run1();
};

void() actorvile_idle1	=[	$stand1,	actorvile_idle2	] {actorvile_stand();};
void() actorvile_idle2	=[	$stand2,	actorvile_idle3	] {actorvile_stand();};
void() actorvile_idle3	=[	$stand3,	actorvile_idle4	] {actorvile_stand();};
void() actorvile_idle4	=[	$stand4,	actorvile_idle5	] {actorvile_stand();};
void() actorvile_idle5	=[	$stand5,	actorvile_idle6	] {actorvile_stand();};
void() actorvile_idle6	=[	$stand6,	actorvile_idle7	] {actorvile_stand();};
void() actorvile_idle7	=[	$stand7,	actorvile_idle8	] {actorvile_stand();};
void() actorvile_idle8	=[	$stand8,	actorvile_idle9	] {actorvile_stand();};
void() actorvile_idle9	=[	$stand9,	actorvile_idle10	] {actorvile_stand();};
void() actorvile_idle10	=[	$stand10,	actorvile_idle11	] {actorvile_stand();};
void() actorvile_idle11	=[	$stand11,	actorvile_idle12	] {actorvile_stand();};
void() actorvile_idle12	=[	$stand12,	actorvile_idle13	] {actorvile_stand();};
void() actorvile_idle13	=[	$stand13,	actorvile_idle14	] {actorvile_stand();};
void() actorvile_idle14	=[	$stand14,	actorvile_idle15	] {actorvile_stand();};
void() actorvile_idle15	=[	$stand15,	actorvile_idle16	] {actorvile_stand();};
void() actorvile_idle16	=[	$stand16,	actorvile_idle17	] {actorvile_stand();};
void() actorvile_idle17	=[	$stand17,	actorvile_idle1	] {actorvile_stand();};

void() actorvileJumpTouch =
{
	local	float	damg;

	if (self.health <= 0)
		return;

	if (other.takedamage)
	{
		self.lock_finished = time + 99999;
		T_Damage (other, self, self, 999);
		self.goalentity = world;
		self.th_stand();
	}
};

void() actorvile_jump1	=[	$jump1,	actorvile_jump2	] 
{
	self.hostile_finished = time + 1;
	ai_face();
};
void() actorvile_jump2	=[	$jump2,	actorvile_jump3	] {ai_face();};
void() actorvile_jump3	=[	$jump3,	actorvile_jump4	] {ai_face();};
void() actorvile_jump4	=[	$jump4,	actorvile_jump5	] 
{
	ai_face();
	playsound (self, CHAN_VOICE, "vile/leap.wav", 1, ATTN_NORM);
	makevectors (self.angles);
	self.touch = actorvileJumpTouch;
	self.origin_z = self.origin_z + 1;
	self.velocity = v_forward * 500 + '0 0 200';
	if (self.flags & FL_ONGROUND)
		self.flags = self.flags - FL_ONGROUND;
};
void() actorvile_jump5	=[	$jump5,	actorvile_jump6	] {};
void() actorvile_jump6	=[	$jump6,	actorvile_jump7	] {};
void() actorvile_jump7	=[	$jump7,	actorvile_jump8	] {};
void() actorvile_jump8	=[	$jump8,	actorvile_jump9	] {};
void() actorvile_jump9	=[	$jump9,	actorvile_jump10	] {};
void() actorvile_jump10	=[	$jump10,	actorvile_jump11	] {};

void() actorvile_jump12;
void() actorvile_jump11	=[	$jump11,	actorvile_jump11	] 
{
	if (self.flags & FL_ONGROUND)
	{
		actorvile_jump12(); // land it
		self.touch = SUB_Null;
	}
};

void() actorvile_jump12	=[	$jump12,	actorvile_jump13	] {};
void() actorvile_jump13	=[	$jump13,	actorvile_jump14	] {};
void() actorvile_jump14	=[	$jump14,	actorvile_jump15	] {};
void() actorvile_jump15	=[	$jump15,	actorvile_jump16	] {};
void() actorvile_jump16	=[	$jump16,	actorvile_run1	] {};

void() actor_vile =
{
	precache_model ("progs/vile.mdl");
	precache_sound ("vile/leap.wav");

	setmodel (self, "progs/vile.mdl");

	self.health = self.max_health = 1;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	self.yaw_speed = 20;
	self.th_stand = actorvile_idle1;
	self.th_run = actorvile_run1;
	self.th_missile = actorvile_jump1;
	self.classname = "actor_vile";
	self.lock_finished = 22;

	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	monster_start();
};

//
// Cargo Deck Vile that slaughters a soldier by the generator
//

void() actor1vile_hide1	=[	$roofhide1,	actor1vile_hide2	] {};
void() actor1vile_hide2	=[	$roofhide2,	actor1vile_hide3	] {};
void() actor1vile_hide3	=[	$roofhide3,	actor1vile_hide4	] {};
void() actor1vile_hide4	=[	$roofhide4,	actor1vile_hide5	] 
{
	playsound (self, CHAN_VOICE, "vile/leap.wav", 1, ATTN_NORM);
	self.origin_z = self.origin_z + 1;
	self.velocity = v_forward * 0 + '0 0 200';
	if (self.flags & FL_ONGROUND)
		self.flags = self.flags - FL_ONGROUND;
	self.movetype = MOVETYPE_FLY;
	self.nextthink = time + 0.6;
};
void() actor1vile_hide5	=[	$roofhide5,	actor1vile_hide6	] {playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);};
void() actor1vile_hide6	=[	$roofhide6,	actor1vile_hide6	] 
{
	// make sure the camera's goalentity is reset back to Corporal
	local entity cam;

	cam = find(world, classname, "camera");
	while (cam)
	{
		cam.goalentity = cam.char;
		cam = find(cam, classname, "camera");
	}

	cutscene = FALSE; // End cutscene
	remove(self);
	return;
};

void() actor1vile_decap1	=[	$lunge1,	actor1vile_decap2	] {ai_quickturn();};
void() actor1vile_decap2	=[	$lunge2,	actor1vile_decap3	] {};
void() actor1vile_decap3	=[	$lunge3,	actor1vile_decap4	] {};
void() actor1vile_decap4	=[	$lunge4,	actor1vile_decap5	] {};
void() actor1vile_decap5	=[	$lunge5,	actor1vile_decap6	] {};
void() actor1vile_decap6	=[	$lunge6,	actor1vile_decap7	] {};
void() actor1vile_decap7	=[	$lunge7,	actor1vile_decap8	] {};
void() actor1vile_decap8	=[	$lunge8,	actor1vile_decap9	] 
{
	T_Damage (self.enemy, self, self, 999); // decap soldier actor
};
void() actor1vile_decap9	=[	$lunge9,	actor1vile_decap10	] {};
void() actor1vile_decap10	=[	$lunge10,	actor1vile_decap11	] {};
void() actor1vile_decap11	=[	$lunge11,	actor1vile_hide1	] // hide right after decap
{
	// show the vile's leaping capabilities by having the camera track the vile's jump
	local entity cam;

	cam = find(world, classname, "camera");
	while (cam)
	{
		cam.goalentity = self;
		cam = find(cam, classname, "camera");
	}
};

void() actor1vile_think =
{
	local float r;

	if (self.goalentity)
	{
		r = range(self.goalentity);
		if (r <= RANGE_MELEE)
		{
			ai_quickturn();
			actor1vile_decap1();
		}
		ChangeYaw();
		movetogoal(8);
	}
};

void() actor1vile_run1	=[	$run1,	actor1vile_run2	] {actor1vile_think();};
void() actor1vile_run2	=[	$run2,	actor1vile_run3	] {actor1vile_think();};
void() actor1vile_run3	=[	$run3,	actor1vile_run4	] {actor1vile_think();};
void() actor1vile_run4	=[	$run4,	actor1vile_run5	] {actor1vile_think();};
void() actor1vile_run5	=[	$run5,	actor1vile_run6	] {actor1vile_think();};
void() actor1vile_run6	=[	$run6,	actor1vile_run7	] {actor1vile_think();};
void() actor1vile_run7	=[	$run7,	actor1vile_run8	] {actor1vile_think();};
void() actor1vile_run8	=[	$run8,	actor1vile_run9	] {actor1vile_think();};
void() actor1vile_run9	=[	$run9,	actor1vile_run10	] {actor1vile_think();};
void() actor1vile_run10	=[	$run10,	actor1vile_run11	] {actor1vile_think();};
void() actor1vile_run11	=[	$run11,	actor1vile_run12	] {actor1vile_think();};
void() actor1vile_run12	=[	$run12,	actor1vile_run13	] {actor1vile_think();};
void() actor1vile_run13	=[	$run13,	actor1vile_run14	] {actor1vile_think();};
void() actor1vile_run14	=[	$run14,	actor1vile_run15	] {actor1vile_think();};
void() actor1vile_run15	=[	$run15,	actor1vile_run1	] {actor1vile_think();};