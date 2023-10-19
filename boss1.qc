$frame base

$frame death1 death2 death3 death4 death5 death6

$frame pain1 pain2 pain3 pain4 pain5

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9 stand10 stand11 stand12

$frame rock1 rock2 rock3 rock4 rock5 rock6

$frame nail1 nail2

$frame run1 run2 run3 run4 run5 run6

//

void() boss1_idle1	=[	$stand1,	boss1_idle2	] {ai_stand();};
void() boss1_idle2	=[	$stand2,	boss1_idle3	] {ai_stand();};
void() boss1_idle3	=[	$stand3,	boss1_idle4	] {ai_stand();};
void() boss1_idle4	=[	$stand4,	boss1_idle5	] {ai_stand();};
void() boss1_idle5	=[	$stand5,	boss1_idle6	] {ai_stand();};
void() boss1_idle6	=[	$stand6,	boss1_idle7	] {ai_stand();};
void() boss1_idle7	=[	$stand7,	boss1_idle8	] {ai_stand();};
void() boss1_idle8	=[	$stand8,	boss1_idle9	] {ai_stand();};
void() boss1_idle9	=[	$stand9,	boss1_idle10	] {ai_stand();};
void() boss1_idle10	=[	$stand10,	boss1_idle11	] {ai_stand();};
void() boss1_idle11	=[	$stand11,	boss1_idle12	] {ai_stand();};
void() boss1_idle12	=[	$stand12,	boss1_idle1 	] {ai_stand();};

void() boss1_run1	=[	$run1,	boss1_run2	] 
{
	self.yaw_speed = 20; // changes
	ai_run(self.speed);
};
void() boss1_run2	=[	$run2,	boss1_run3	] {ai_run(self.speed);};
void() boss1_run3	=[	$run3,	boss1_run4	] {ai_run(self.speed);};
void() boss1_run4	=[	$run4,	boss1_run5	] {ai_run(self.speed);};
void() boss1_run5	=[	$run5,	boss1_run6	] {ai_run(self.speed);};
void() boss1_run6	=[	$run6,	boss1_run1	] {ai_run(self.speed);};

void() boss1_pain1	=[	$pain1,	boss1_pain2	] {};
void() boss1_pain2	=[	$pain2,	boss1_pain3	] {};
void() boss1_pain3	=[	$pain3,	boss1_pain4	] {};
void() boss1_pain4	=[	$pain4,	boss1_pain5	] {};
void() boss1_pain5	=[	$pain5,	boss1_run1 ] {};

void() boss1_pain =
{
	local float r;

	if (self.pain_finished > time)
		return;
	if (self.health > self.max_health / 2)
		return;
	r = random();
	if (random() < 0.40) // flinch
		return;

	self.pain_finished = time + 0.5;
	boss1_pain1();
};

void() boss1_death1	=[	$death1,	boss1_death2	] {};
void() boss1_death2	=[	$death2,	boss1_death3	] {};
void() boss1_death3	=[	$death3,	boss1_death4	] {};
void() boss1_death4	=[	$death4,	boss1_death5	] {};
void() boss1_death5	=[	$death5,	boss1_death6	] {};
void() boss1_death6	=[	$death6,	boss1_death6	] 
{
	local entity thing;

	thing = find(world, classname, "camera");
	while (thing)
	{
		centerprint (thing, "Congratulations!\nYou've beaten the Codename: Envenom\nPreview!\n");
		thing = find(thing, classname, "camera");
	}
	self.solid = SOLID_NOT;
};

void() bossgrenadetouch =
{
	local float damg;
	
	damg = 35;
	if (other.takedamage)
		T_Damage (other, self, self.owner, 20);
	T_RadiusDamage (self, self.owner, damg, world);
	BecomeExplosion();
};

void() boss1_firegren =
{
	local	entity missile;
	local   float   dist, base, g;

	g = cvar("sv_gravity") * 0.00125;
	
	ai_face();
	self.effects = self.effects | EF_MUZZLEFLASH;

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_TOSS;
	missile.solid = SOLID_BBOX;
		
	// set missile speed	
	makevectors (self.angles);
	missile.velocity = normalize(self.enemy.origin - self.origin);
	missile.velocity = missile.velocity * 600;

	dist = vlen(self.enemy.origin - self.origin);

	if (self.enemy.velocity_x || self.enemy.velocity_y)
		if (random() < 0.9)
	dist = dist - random()*300;
	if (dist > 900)
		base = 200+((dist - (200 - (dist * 0.2)))*0.5);
	else if (dist > 700)
		base = 200+((dist - (200 - (dist * 0.15)))*0.5);
	else if (dist > 500)
		base = 200+((dist - (200 - (dist * 0.1)))*0.5);
	else if (dist > 200)
		base = 200+((dist - 200)*0.5);
	else
		base = 200;

	missile.velocity_z = (missile.velocity_z + (base * g));
	missile.avelocity = '300 300 300';
	missile.angles = vectoangles(missile.velocity);
	missile.touch = bossgrenadetouch;

	setmodel (missile, "progs/grenade.mdl");
	setsize (missile, '0 0 0', '0 0 0');		
	setorigin (missile, self.origin + v_forward*12 - v_right * 18 + '0 0 16');
};

void() boss1_grenfire1	=[	$rock1,	boss1_grenfire2	] {};
void() boss1_grenfire2	=[	$rock2,	boss1_grenfire3	] {};
void() boss1_grenfire3	=[	$rock3,	boss1_grenfire4	] {boss1_firegren();};
void() boss1_grenfire4	=[	$rock4,	boss1_grenfire5	] {};
void() boss1_grenfire5	=[	$rock5,	boss1_grenfire6	] {};
void() boss1_grenfire6	=[	$rock6,	boss1_run1	] {};

void() boss1_firemach =
{
	local entity newmis;

	ai_face();
	self.effects = self.effects | EF_MUZZLEFLASH;

	makevectors (self.angles);
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.velocity = aim(self, 2000);
	newmis.velocity = newmis.velocity * 2000;
	newmis.velocity = ((newmis.velocity + ((v_right * 50) * crandom ())) + ((v_up * 50) * crandom ()));
	newmis.angles = vectoangles(newmis.velocity);
	newmis.touch = T_BulletTouch;
	newmis.classname = "projectile";
	setmodel (newmis, "progs/bullet.mdl");
	setsize (newmis, '0 0 0', '0 0 0');
	setorigin (newmis, self.origin + v_forward*12 - v_right * 18 + '0 0 16');
	newmis.bullettype = 2;
};

void() boss1_machgun1	=[	$nail1,	boss1_machgun2	] 
{
	playsound (self, CHAN_WEAPON, "weapons/assault.wav", 1, ATTN_NORM); // change me
	self.yaw_speed = 3;
	boss1_firemach();
};
void() boss1_machgun2	=[	$nail2,	boss1_run1	] {self.yaw_speed = 3;boss1_firemach();};

void() boss1_attack =
{
	local float r;

	r = random();

	if (self.cnt == 0) // randomize weapon selection
	{
		self.weapon = 0;
		if (r < 0.5) self.cnt = 1; // use mach gun
		else self.cnt = 2; // use gren launcher
	}

	if (self.cnt == 1)
	{
		if (self.lock_finished < time)
		{
			if (self.weapon < 8) // how many shots before cool down
			{
				boss1_machgun1();
				self.weapon = self.weapon + 1;
			}
			else
				self.lock_finished = time + 0.5; // 1 second break before firing a grenade
		}
		else
			self.cnt = 0;
	}
	else if (self.cnt == 2)
	{
		if (self.lock_finished < time)
		{
			boss1_grenfire1();
			self.lock_finished = time + 1; // 2 second break before firing a grenade
		}
		self.cnt = 0;
	}
};

void() monster_boss1 =
{
	precache_model ("progs/boss1.mdl");
	precache_model ("progs/grenade.mdl");
	precache_sound ("ambience/spark1.wav");
	precache_sound ("ambience/spark2.wav");
	precache_sound ("ambience/spark3.wav");
	precache_sound ("ambience/spark4.wav");

	self.health = self.max_health = 400;
	self.teams = "robot";
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	self.th_stand = boss1_idle1;
	self.th_run = boss1_run1;
	self.th_missile = boss1_attack;
	self.th_pain = boss1_pain;
	self.speed = 9;
	self.th_die = boss1_death1;
	self.classname = "boss1";
	setmodel (self, "progs/boss1.mdl");
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	monster_start();
};