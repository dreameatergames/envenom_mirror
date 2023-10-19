$frame run1 run2 run3 run4 run5 run6 run7

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9 death10

//

void() bloodspray_particlethink = 
{
	if (self.lock_finished < time)
		remove(self);

	particle (self.origin, '0 0 0', 73, 10); // red
	self.nextthink = time + 0.1;
};

void() bloodspray_spawn =
{
	local entity bs;

	bs = spawn();

	setmodel (bs, "progs/null.spr");
	bs.movetype = MOVETYPE_TOSS;
	bs.solid = SOLID_NOT;
	bs.classname = "particle";
	setorigin (bs, self.origin + v_up*25);
	setsize(bs, '0 0 0', '0 0 0');

	bs.angles_y = bs.angles_y + random()*360;
	makevectors (bs.angles);
	bs.velocity = v_forward* 10;
	bs.velocity_z = 80 + random()*100;

	bs.lock_finished = time + 0.3 + random()*0.6;
	bs.think = bloodspray_particlethink;
	bs.nextthink = time + 0.1;
};

void() nhzombie_death1	=[	$death1,	nhzombie_death2	] {self.solid = SOLID_NOT;};
void() nhzombie_death2	=[	$death2,	nhzombie_death3	] {};
void() nhzombie_death3	=[	$death3,	nhzombie_death4	] {};
void() nhzombie_death4	=[	$death4,	nhzombie_death5	] {};
void() nhzombie_death5	=[	$death5,	nhzombie_death6	] {};
void() nhzombie_death6	=[	$death6,	nhzombie_death7	] {};
void() nhzombie_death7	=[	$death7,	nhzombie_death8	] {};
void() nhzombie_death8	=[	$death8,	nhzombie_death9	] 
{
	playsound (self, CHAN_BODY, "misc/florhit.wav", 1, ATTN_NORM);
};

void() nhzombie_death9	=[	$death9,	nhzombie_death10	] {self.cnt = FALSE;blood(36,0,2); // f,s,sz
};
void() nhzombie_death10	=[	$death10,	nhzombie_death10	]
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

void() nhzombie_run1	=[	$run1,	nhzombie_run2	] 
{
	bloodspray_spawn();
	self.cnt = self.cnt + 1; // count towards eventual falldown
	self.health = 666;
	walkmove (self.angles_y, self.speed);
	self.ideal_yaw = self.angles_y + (crandom()*360);
	ChangeYaw();
	playsound (self, CHAN_BODY, "zombie/step.wav", 1, ATTN_NORM);
};
void() nhzombie_run2	=[	$run2,	nhzombie_run3	] {walkmove (self.angles_y, self.speed);};
void() nhzombie_run3	=[	$run3,	nhzombie_run4	] {bloodspray_spawn();walkmove (self.angles_y, self.speed);};
void() nhzombie_run4	=[	$run4,	nhzombie_run5	] {walkmove (self.angles_y, self.speed);};
void() nhzombie_run5	=[	$run5,	nhzombie_run6	] 
{
	bloodspray_spawn();
	self.health = 666;
	walkmove (self.angles_y, self.speed);
	self.ideal_yaw = self.angles_y + (crandom()*360);
	ChangeYaw();
	playsound (self, CHAN_BODY, "zombie/step.wav", 1, ATTN_NORM);
	if (self.cnt >= 4) // if the zombie has walked around for a bit then force him to fall down
		T_Damage (self, self, self, self.health);
};
void() nhzombie_run6	=[	$run6,	nhzombie_run7	] {walkmove (self.angles_y, self.speed);};
void() nhzombie_run7	=[	$run7,	nhzombie_run1	] {bloodspray_spawn();walkmove (self.angles_y, self.speed);};