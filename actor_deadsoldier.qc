$frame stand1 stand2 stand3 stand4 stand5 stand6

$frame runa1 runa2 runa3 runa4 runa5 runa6

$frame shoota1 shoota2 shoota3 shoota4

$frame paina1 paina2 paina3 paina4 paina5 paina6 paina7

$frame painb1 painb2 painb3 painb4

$frame stomp1 stomp2 stomp3 stomp4 stomp5 stomp6

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8 deathc9

void() deadsoldier1_shoot1;

void() actor_deadsoldier1Think =
{
	ChangeYaw();
	if (random() < 0.2 && self.cnt < 35)
	{
		self.yaw_speed = 35;
		self.ideal_yaw = self.angles_y + (crandom()*360);
	}

	if (self.cnt == 20)
		sound (self, CHAN_VOICE, "speech/deadguy2.wav", 1, ATTN_NORM); // play speech
	if (self.cnt == 45)
	{
		// spawn vile that kills this man
		local entity avile;

		avile = spawn ();
		avile.owner = self;
		avile.movetype = MOVETYPE_STEP;
		avile.solid = SOLID_SLIDEBOX;
		avile.classname = "vile";
		setmodel (avile, "progs/vile.mdl");
		setsize(avile, VEC_HULL_MIN, VEC_HULL_MAX);
		setorigin (avile, '-1736 328 -512'); // actor's placement
		avile.health = avile.max_health = 100;
		avile.teams = "envenom";
		avile.classname = "actor2";
		avile.think = actor1vile_run1;
		avile.nextthink = time + 0.1;

		// link actors
		self.enemy = avile;
		self.goalentity = avile;
		avile.enemy = self;
		avile.yaw_speed = 35;
		avile.goalentity = self;
		avile.ideal_yaw = vectoyaw(self.enemy.origin - avile.origin);
	}
	if (self.cnt == 49)
	{
		// now tell the soldier to LOOK first at the vile then start shooting!!
		sound (self, CHAN_VOICE, "speech/deadguy3.wav", 1, ATTN_NORM); // play speech
		self.ideal_yaw = vectoyaw(self.enemy.origin - self.origin);
		self.th_missile = deadsoldier1_shoot1;
		self.th_missile();
	}
	self.cnt = self.cnt + 1;
};

void() deadsoldier1_idle1	=[	$stand1,	deadsoldier1_idle2	] {actor_deadsoldier1Think();};
void() deadsoldier1_idle2	=[	$stand2,	deadsoldier1_idle3	] {actor_deadsoldier1Think();};
void() deadsoldier1_idle3	=[	$stand3,	deadsoldier1_idle4	] {actor_deadsoldier1Think();};
void() deadsoldier1_idle4	=[	$stand4,	deadsoldier1_idle5	] {actor_deadsoldier1Think();};
void() deadsoldier1_idle5	=[	$stand5,	deadsoldier1_idle6	] {actor_deadsoldier1Think();};
void() deadsoldier1_idle6	=[	$stand6,	deadsoldier1_idle1	] {actor_deadsoldier1Think();};

void() deadsoldier1_death =
{
	ThrowHead ("progs/h_solder.mdl", self.health);
	setmodel(self, "progs/decap3.mdl");
	setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
	soldier_decap1();
	playsound (self, CHAN_BODY, "player/decaped.wav", 1, ATTN_NORM);
	blood(-23,0,2);
};

void() deadsoldier1_shoot1	=[	$shoota1,	deadsoldier1_shoot2	] 
{
	ai_quickturn();
	ThrowCasing();
	MuzzleFlash(13, 0, 32); // up, right, forward
	self.effects = EF_MUZZLEFLASH;
	SoldierPistol();
	playsound (self, CHAN_WEAPON, "weapons/pistol.wav", 1, ATTN_NORM);
	ai_quickturn();
};
void() deadsoldier1_shoot2	=[	$shoota2,	deadsoldier1_shoot3	] {ai_quickturn();};
void() deadsoldier1_shoot3	=[	$shoota3,	deadsoldier1_shoot4	] {ai_quickturn();};
void() deadsoldier1_shoot4	=[	$shoota4,	deadsoldier1_shoot1	] {};