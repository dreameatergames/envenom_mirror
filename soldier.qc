$frame stand1 stand2 stand3 stand4 stand5 stand6

$frame runa1 runa2 runa3 runa4 runa5 runa6

$frame shoota1 shoota2 shoota3 shoota4

$frame paina1 paina2 paina3 paina4 paina5 paina6 paina7

$frame painb1 painb2 painb3 painb4

$frame stomp1 stomp2 stomp3 stomp4 stomp5 stomp6

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8 deathc9

$frame jumpa1 jumpa2 jumpa3 jumpa4 jumpa5 jumpa6

//

.float voice; // which voice the soldier will use

void() soldier_stand1	=[	$stand1,	soldier_stand2	] {ai_stand();};
void() soldier_stand2	=[	$stand2,	soldier_stand3	] {ai_stand();};
void() soldier_stand3	=[	$stand3,	soldier_stand4	] {ai_stand();};
void() soldier_stand4	=[	$stand4,	soldier_stand5	] {ai_stand();};
void() soldier_stand5	=[	$stand5,	soldier_stand6	] {ai_stand();};
void() soldier_stand6	=[	$stand6,	soldier_stand1	] {ai_stand();};

void() soldier_run1	=[	$runa1,	soldier_run2	] {ai_run(self.speed);};
void() soldier_run2	=[	$runa2,	soldier_run3	] 
{
	if (self.frags != 0) // for cutscene usage
		self.frags = 0;
	ai_run(self.speed);
	if (random() < 0.50)
		playsound (self, CHAN_BODY, "soldier/step1.wav", 1, ATTN_NORM);
	else
		playsound (self, CHAN_BODY, "soldier/step2.wav", 1, ATTN_NORM);
};
void() soldier_run3	=[	$runa3,	soldier_run4	] {ai_run(self.speed);};
void() soldier_run4	=[	$runa4,	soldier_run5	] {ai_run(self.speed);};
void() soldier_run5	=[	$runa5,	soldier_run6	] 
{
	ai_run(self.speed);
	if (self.flags & FL_ONGROUND)
	{
		if (random() < 0.50)
			playsound (self, CHAN_BODY, "soldier/step1.wav", 1, ATTN_NORM);
		else
			playsound (self, CHAN_BODY, "soldier/step2.wav", 1, ATTN_NORM);
	}
};
void() soldier_run6	=[	$runa6,	soldier_run1	] {ai_run(self.speed);};

void() soldier_paina1	=[	$paina1,	soldier_paina2	] {};
void() soldier_paina2	=[	$paina2,	soldier_paina3	] {};
void() soldier_paina3	=[	$paina3,	soldier_paina4	] {};
void() soldier_paina4	=[	$paina4,	soldier_paina5	] {};
void() soldier_paina5	=[	$paina5,	soldier_paina6	] {};
void() soldier_paina6	=[	$paina6,	soldier_paina7	] {};
void() soldier_paina7	=[	$paina7,	soldier_run1	] {};

void() soldier_painb1	=[	$painb1,	soldier_painb2	] {};
void() soldier_painb2	=[	$painb2,	soldier_painb3	] {};
void() soldier_painb3	=[	$painb3,	soldier_painb4	] {self.nextthink = time + 0.4;};
void() soldier_painb4	=[	$painb4,	soldier_run1	] {};

void() soldier_pain =
{
	local float r, rs;
	r = random();

	if (self.attacker.teams == "human")
	{
		if (self.attacker.classname == "player" && self.ai_angry == FALSE)
		{
			// ai anger set off count
			if (self.enemy)
				self.frags = 8; // Don't get angry at player as easily if in combat
			else
				self.frags = 4;

			if (self.cnt >= self.frags) // player betrayed this ally
			{
				self.ai_angry = TRUE;
				if (self.friend)
					self.friend = world;
				self.enemy = self.attacker;
				FoundTarget();
			}
			else
				soldier_speak(1);
			self.cnt = self.cnt + 1; // hit count
		}
	}
	else
		soldier_speak(2);

	if (self.pain_finished > time)
		return;
	if (self.health > 50)
		return;
	if (r < 0.7) // don't flinch all the time
		return;

	if (r < 0.5)
	{
		self.pain_finished = time + 0.7;
		soldier_paina1();
	}
	else
	{
		self.pain_finished = time + 0.6;
		soldier_painb1();
	}
};

void() SoldierPistol =
{
	local entity newmis;

	makevectors (self.angles);
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.velocity = aim(self, 2000);
	newmis.velocity = newmis.velocity * 2000;
	newmis.angles = vectoangles(newmis.velocity);
	newmis.touch = T_BulletTouch;
	newmis.classname = "projectile";
	setmodel (newmis, "progs/bullet.mdl");
	setsize (newmis, '0 0 0', '0 0 0');
	setorigin (newmis, self.origin + v_forward*42 + '0 0 25');
	newmis.bullettype = 600;
};

void() soldier_jumpa1   =[    $jumpa1,    soldier_jumpa2    ] {};
void() soldier_jumpa2   =[    $jumpa2,    soldier_jumpa3    ] {ai_jump();};
void() soldier_jumpa3   =[    $jumpa3,    soldier_jumpa4    ] {};
void() soldier_jumpa4   =[    $jumpa4,    soldier_jumpa5    ] {};
void() soldier_jumpa5   =[    $jumpa5,    soldier_jumpa6    ] {};
void() soldier_jumpa6   =[    $jumpa6,    soldier_jumpa6    ] {if (self.flags & FL_ONGROUND) soldier_run1();};

void() soldier_stomp1   =[    $stomp1,    soldier_stomp2    ] {ai_face();};
void() soldier_stomp2   =[    $stomp2,    soldier_stomp3    ] {ai_face();};
void() soldier_stomp3   =[    $stomp3,    soldier_stomp4    ] {ai_face();};
void() soldier_stomp4   =[    $stomp4,    soldier_stomp5    ] {ai_face();};
void() soldier_stomp5   =[    $stomp5,    soldier_stomp6    ] {ai_face();};
void() soldier_stomp6   =[    $stomp6,    soldier_run1      ] 
{
	// worm radius check
	local entity y, tmp;

	y = findradius(self.origin + v_up * 4, 80);
	while (y)
	{
		if (y.classname == "worm" && y.health > 0)
		{
			// stepped on
			particle (y.origin, '0 0 0', 59, 6); // green particle
			sound (y, CHAN_BODY, "worm/squish.wav", 1, ATTN_NORM);
			T_Damage (y, self, self, 1);
			y.angles_y = y.angles_y + (crandom()*360);
			y.health = 0; 
			tmp = self;
			self = y;
			droptofloor();
			self = tmp;
		}
		y = y.chain;
	}
};

void() soldier_shoot1	=[	$shoota1,	soldier_shoot2	] 
{
	ThrowCasing();
	MuzzleFlash(25, 0, 32); // up, right, forward
	self.effects = EF_MUZZLEFLASH;
	SoldierPistol();
	playsound (self, CHAN_WEAPON, "weapons/pistol.wav", 1, ATTN_NORM);
	self.hostile_finished = time + 0.2;
};
void() soldier_shoot2	=[	$shoota2,	soldier_shoot3	] {};
void() soldier_shoot3	=[	$shoota3,	soldier_shoot4	] 
{
	local vector source;

	makevectors (self.angles);

	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*99999, FALSE, self);
	if (trace_fraction == 1)
		return;
	// make sure you're not gonna hit a teammate unless you're angry at em
	if (trace_ent.teams == self.teams && self.ai_angry == FALSE)
		return;

	if (visible(self.enemy) && infront(self.enemy) && self.enemy.health > 0)
	{
		ai_face();
		self.think = soldier_shoot1;
		self.nextthink = time + 0.25;
	}
};
void() soldier_shoot4	=[	$shoota4,	soldier_run1	] {};

void() soldier_deathc1	=[	$deathc1,	soldier_deathc2	] {};
void() soldier_deathc2	=[	$deathc2,	soldier_deathc3	] {};
void() soldier_deathc3	=[	$deathc3,	soldier_deathc4	] {};
void() soldier_deathc4	=[	$deathc4,	soldier_deathc5	] {};
void() soldier_deathc5	=[	$deathc5,	soldier_deathc6	] {};
void() soldier_deathc6	=[	$deathc6,	soldier_deathc7	] {};
void() soldier_deathc7	=[	$deathc7,	soldier_deathc8	] {};
void() soldier_deathc8	=[	$deathc8,	soldier_deathc9	] 
{
	blood(0,0,6);
	playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);
};
void() soldier_deathc9	=[	$deathc9,	soldier_deathc9	] {};

void() soldier_decap1	=[0,		soldier_decap2] {};
void() soldier_decap2	=[1,		soldier_decap3] {};
void() soldier_decap3	=[2,		soldier_decap4] {};
void() soldier_decap4	=[3,		soldier_decap5] {};
void() soldier_decap5	=[4,		soldier_decap6] 
{
	if (self.flags & FL_ONGROUND)
		playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);
};
void() soldier_decap6	=[5,		soldier_decap6] {};

void() soldier_death =
{
	local float		rs;

	if (self.deathtype != 1)
	{	
		rs = rint ((random() * 4) + 1);
		if (rs == 1)
			self.noise = "player/death1.wav";
		if (rs == 2)
			self.noise = "player/death2.wav";
		if (rs == 3)
			self.noise = "player/death3.wav";
		if (rs == 4)
			self.noise = "player/death4.wav";
		if (rs == 5)
			self.noise = "player/death5.wav";

		sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	}

	if (self.deathtype == 0)
		soldier_deathc1();
	else if (self.deathtype == 1)
	{
		ThrowHead ("progs/h_solder.mdl", self.health);
		setmodel(self, "progs/decap3.mdl");
		setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
		soldier_decap1();
		playsound (self, CHAN_BODY, "player/decaped.wav", 1, ATTN_NORM);
		blood(-23,0,2);
	}
};

void(float topic) soldier_speak =
{
	local float r, rs;
	local entity y;

	if (self.voice_finished > time && topic != 6 && topic != 3)
		return;

	if (topic != 6) // soldiers always say something when they see corporals death
	{
		y = find(world, teams, "human");
		while (y)
		{
			if (y != self)
			{
				if (y.voice_finished > time)
					return; // don't have all marine speak at once
			}
			y = find(y, teams, "human");
		}
	}

	r = random();

	if (topic == 0) // enemy spotted
	{
		rs = rint ((random() * 6) + 1);

		if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice0/sight1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice0/sight2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice0/sight3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice0/sight4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice0/sight5.wav", 1, ATTN_NORM);
			else if (rs == 6)
				playsound (self, CHAN_VOICE, "soldier/voice0/sight6.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice0/sight7.wav", 1, ATTN_NORM);
		}
		else if (self.voice == 1)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice1/sight1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice1/sight2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice1/sight3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice1/sight4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice1/sight5.wav", 1, ATTN_NORM);
			else if (rs == 6)
				playsound (self, CHAN_VOICE, "soldier/voice1/sight6.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice1/sight7.wav", 1, ATTN_NORM);
		}
	}
	else if (topic == 1) // attacked by teammate
	{
		if (self.ai_angry == TRUE) // don't apologize if angry at teammate
			return;

		rs = rint ((random() * 4) + 1);

		if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice0/teamatk1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice0/teamatk2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice0/teamatk3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice0/teamatk4.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice0/teamatk5.wav", 1, ATTN_NORM);
		}
		else if (self.voice == 1)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice1/teamatk1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice1/teamatk2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice1/teamatk3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice1/teamatk4.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice1/teamatk5.wav", 1, ATTN_NORM);
		}
	}
	else if (topic == 2) // hit by a monster
	{
		if (r > 0.6)
			return;

		rs = rint ((random() * 4) + 1);

		if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice0/monatk1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice0/monatk2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice0/monatk3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice0/monatk4.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice0/monatk5.wav", 1, ATTN_NORM);
		}
		else if (self.voice == 1)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice1/monatk1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice1/monatk2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice1/monatk3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice1/monatk4.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice1/monatk5.wav", 1, ATTN_NORM);
		}
	}
	else if (topic == 3) // misfire hit corporal
	{
		if (self.ai_angry == TRUE)
			return;

		rs = rint ((random() * 5) + 1);

		if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice0/misfire1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice0/misfire2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice0/misfire3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice0/misfire4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice0/misfire5.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice0/misfire6.wav", 1, ATTN_NORM);
		}
		else if (self.voice == 1)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice1/misfire1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice1/misfire2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice1/misfire3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice1/misfire4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice1/misfire5.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice1/misfire6.wav", 1, ATTN_NORM);
		}
	}
	else if (topic == 4) // soldier spotted corporal
	{
		rs = rint ((random() * 5) + 1);

		if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice0/fsight1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice0/fsight2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice0/fsight3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice0/fsight4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice0/fsight5.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice0/fsight6.wav", 1, ATTN_NORM);
		}
		if (self.voice == 1)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice1/fsight1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice1/fsight2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice1/fsight3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice1/fsight4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice1/fsight5.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice1/fsight6.wav", 1, ATTN_NORM);
		}
	}
	else if (topic == 5) // soldier killed monster
	{
		if (r > 0.5)
			return;

		rs = rint ((random() * 5) + 1);

		if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice0/killed1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice0/killed2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice0/killed3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice0/killed4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice0/killed5.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice0/killed6.wav", 1, ATTN_NORM);
		}
		else if (self.voice == 1)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice1/killed1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice1/killed2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice1/killed3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice1/killed4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice1/killed5.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice1/killed6.wav", 1, ATTN_NORM);
		}
	}
	else if (topic == 6) // soldier reacts to corporals death
	{
		rs = rint ((random() * 5) + 1);

		if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice0/cdeath1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice0/cdeath2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice0/cdeath3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice0/cdeath4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice0/cdeath5.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice0/cdeath6.wav", 1, ATTN_NORM);
		}
		else if (self.voice == 1)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice1/cdeath1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice1/cdeath2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice1/cdeath3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice1/cdeath4.wav", 1, ATTN_NORM);
			else if (rs == 5)
				playsound (self, CHAN_VOICE, "soldier/voice1/cdeath5.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice1/cdeath6.wav", 1, ATTN_NORM);
		}
	}
	else if (topic == 7) // soldier lost sight of corporal
	{
		rs = rint ((random() * 4) + 1);

		if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice0/wait1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice0/wait2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice0/wait3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice0/wait4.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice0/wait5.wav", 1, ATTN_NORM);
		}
		else if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice1/wait1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice1/wait2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice1/wait3.wav", 1, ATTN_NORM);
			else if (rs == 4)
				playsound (self, CHAN_VOICE, "soldier/voice1/wait4.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice1/wait5.wav", 1, ATTN_NORM);
		}
	}
	else if (topic == 8) // soldier is betrayed by Corporal
	{
		rs = rint ((random() * 3) + 1);

		if (self.voice == 0)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice0/traitor1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice0/traitor2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice0/traitor3.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice0/traitor4.wav", 1, ATTN_NORM);
		}
		if (self.voice == 1)
		{
			if (rs == 1)
				playsound (self, CHAN_VOICE, "soldier/voice1/traitor1.wav", 1, ATTN_NORM);
			else if (rs == 2)
				playsound (self, CHAN_VOICE, "soldier/voice1/traitor2.wav", 1, ATTN_NORM);
			else if (rs == 3)
				playsound (self, CHAN_VOICE, "soldier/voice1/traitor3.wav", 1, ATTN_NORM);
			else
				playsound (self, CHAN_VOICE, "soldier/voice1/traitor4.wav", 1, ATTN_NORM);
		}
	}
	self.voice_finished = time + 3;
};

void() soldier_touch = // have soldiers face whomever touches them if they aren't following corporal
{			     // (stops soldiers from sitting still blocking corporal in narrow passageways)
	if (!self.friend && other.classname == "player")
	{
		self.goalentity = other;
		ai_face();
	}
};

void() monster_soldier =
{
	precache_model ("progs/soldier.mdl");
	precache_model ("progs/decap3.mdl");
	precache_model ("progs/h_solder.mdl");

	precache_sound ("soldier/step1.wav");
	precache_sound ("soldier/step2.wav");
	precache_sound ("player/death1.wav");
	precache_sound ("player/death2.wav");
	precache_sound ("player/death3.wav");
	precache_sound ("player/death4.wav");
	precache_sound ("player/death5.wav");

	if (self.voice == 0)
	{
		precache_sound ("soldier/voice0/cdeath1.wav");
		precache_sound ("soldier/voice0/cdeath2.wav");
		precache_sound ("soldier/voice0/cdeath3.wav");
		precache_sound ("soldier/voice0/cdeath4.wav");
		precache_sound ("soldier/voice0/cdeath5.wav");
		precache_sound ("soldier/voice0/cdeath6.wav");
		precache_sound ("soldier/voice0/fsight1.wav");
		precache_sound ("soldier/voice0/fsight2.wav");
		precache_sound ("soldier/voice0/fsight3.wav");
		precache_sound ("soldier/voice0/fsight4.wav");
		precache_sound ("soldier/voice0/fsight5.wav");
		precache_sound ("soldier/voice0/fsight6.wav");
		precache_sound ("soldier/voice0/killed1.wav");
		precache_sound ("soldier/voice0/killed2.wav");
		precache_sound ("soldier/voice0/killed3.wav");
		precache_sound ("soldier/voice0/killed4.wav");
		precache_sound ("soldier/voice0/killed5.wav");
		precache_sound ("soldier/voice0/killed6.wav");
		precache_sound ("soldier/voice0/misfire1.wav");
		precache_sound ("soldier/voice0/misfire2.wav");
		precache_sound ("soldier/voice0/misfire3.wav");
		precache_sound ("soldier/voice0/misfire4.wav");
		precache_sound ("soldier/voice0/misfire5.wav");
		precache_sound ("soldier/voice0/misfire6.wav");
		precache_sound ("soldier/voice0/monatk1.wav");
		precache_sound ("soldier/voice0/monatk2.wav");
		precache_sound ("soldier/voice0/monatk3.wav");
		precache_sound ("soldier/voice0/monatk4.wav");
		precache_sound ("soldier/voice0/monatk5.wav");
		precache_sound ("soldier/voice0/sight1.wav");
		precache_sound ("soldier/voice0/sight2.wav");
		precache_sound ("soldier/voice0/sight3.wav");
		precache_sound ("soldier/voice0/sight4.wav");
		precache_sound ("soldier/voice0/sight5.wav");
		precache_sound ("soldier/voice0/sight6.wav");
		precache_sound ("soldier/voice0/sight7.wav");
		precache_sound ("soldier/voice0/teamatk1.wav");
		precache_sound ("soldier/voice0/teamatk2.wav");
		precache_sound ("soldier/voice0/teamatk3.wav");
		precache_sound ("soldier/voice0/teamatk4.wav");
		precache_sound ("soldier/voice0/teamatk5.wav");
		precache_sound ("soldier/voice0/traitor1.wav");
		precache_sound ("soldier/voice0/traitor2.wav");
		precache_sound ("soldier/voice0/traitor3.wav");
		precache_sound ("soldier/voice0/traitor4.wav");
		precache_sound ("soldier/voice0/wait1.wav");
		precache_sound ("soldier/voice0/wait2.wav");
		precache_sound ("soldier/voice0/wait3.wav");
		precache_sound ("soldier/voice0/wait4.wav");
		precache_sound ("soldier/voice0/wait5.wav");
	}
	else if (self.voice == 1)
	{
		precache_sound ("soldier/voice1/cdeath1.wav");
		precache_sound ("soldier/voice1/cdeath2.wav");
		precache_sound ("soldier/voice1/cdeath3.wav");
		precache_sound ("soldier/voice1/cdeath4.wav");
		precache_sound ("soldier/voice1/cdeath5.wav");
		precache_sound ("soldier/voice1/cdeath6.wav");
		precache_sound ("soldier/voice1/fsight1.wav");
		precache_sound ("soldier/voice1/fsight2.wav");
		precache_sound ("soldier/voice1/fsight3.wav");
		precache_sound ("soldier/voice1/fsight4.wav");
		precache_sound ("soldier/voice1/fsight5.wav");
		precache_sound ("soldier/voice1/fsight6.wav");
		precache_sound ("soldier/voice1/killed1.wav");
		precache_sound ("soldier/voice1/killed2.wav");
		precache_sound ("soldier/voice1/killed3.wav");
		precache_sound ("soldier/voice1/killed4.wav");
		precache_sound ("soldier/voice1/killed5.wav");
		precache_sound ("soldier/voice1/killed6.wav");
		precache_sound ("soldier/voice1/misfire1.wav");
		precache_sound ("soldier/voice1/misfire2.wav");
		precache_sound ("soldier/voice1/misfire3.wav");
		precache_sound ("soldier/voice1/misfire4.wav");
		precache_sound ("soldier/voice1/misfire5.wav");
		precache_sound ("soldier/voice1/misfire6.wav");
		precache_sound ("soldier/voice1/monatk1.wav");
		precache_sound ("soldier/voice1/monatk2.wav");
		precache_sound ("soldier/voice1/monatk3.wav");
		precache_sound ("soldier/voice1/monatk4.wav");
		precache_sound ("soldier/voice1/monatk5.wav");
		precache_sound ("soldier/voice1/sight1.wav");
		precache_sound ("soldier/voice1/sight2.wav");
		precache_sound ("soldier/voice1/sight3.wav");
		precache_sound ("soldier/voice1/sight4.wav");
		precache_sound ("soldier/voice1/sight5.wav");
		precache_sound ("soldier/voice1/sight6.wav");
		precache_sound ("soldier/voice1/sight7.wav");
		precache_sound ("soldier/voice1/teamatk1.wav");
		precache_sound ("soldier/voice1/teamatk2.wav");
		precache_sound ("soldier/voice1/teamatk3.wav");
		precache_sound ("soldier/voice1/teamatk4.wav");
		precache_sound ("soldier/voice1/teamatk5.wav");
		precache_sound ("soldier/voice1/traitor1.wav");
		precache_sound ("soldier/voice1/traitor2.wav");
		precache_sound ("soldier/voice1/traitor3.wav");
		precache_sound ("soldier/voice1/traitor4.wav");
		precache_sound ("soldier/voice1/wait1.wav");
		precache_sound ("soldier/voice1/wait2.wav");
		precache_sound ("soldier/voice1/wait3.wav");
		precache_sound ("soldier/voice1/wait4.wav");
		precache_sound ("soldier/voice1/wait5.wav");
	}

	self.health = self.max_health = 100;
	self.teams = "human";
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.th_stand = soldier_stand1;
	self.th_melee = soldier_stomp1; // worm stomp is their melee
	self.th_run = soldier_run1;
	self.touch = soldier_touch;
	self.th_missile = soldier_shoot1;
	self.th_pain = soldier_pain;
	self.th_die = soldier_death;
	self.speed = 10;
	self.classname = "soldier";
	self.voice_finished = time + 1;
	setmodel (self, "progs/soldier.mdl");
	setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
	monster_start();
};