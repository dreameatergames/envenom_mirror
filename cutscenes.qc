// cnt is what cutscene to run:
// cutscene 0 is a vile slaughtering a soldier during the cargo deck level

void() cutscenes_check =
{
	local entity thing, actor1;

	// stop soldiers from being angry at corporal
	thing = find(world, classname, "soldier");
	while (thing)
	{
		if (thing.ai_angry == TRUE && self.frags == 0 && thing.health > 0)
		{
			thing.ai_angry = FALSE; // avoid shoot teammates
			thing.enemy = world;
			thing.think = thing.th_stand;
			thing.nextthink = time + 0.1;
			self.frags = 1;
		}
		thing = find(thing, classname, "soldier");
	}

	//start cutscene
	thing = find(world, classname, "player");
	while (thing)
	{
		if (visible(thing))
		{
			if (self.cnt == 0 && self.mode == FALSE) // spawn cutscene entities here
			{
				cutscene = TRUE;
				stuffcmd(thing.owner, "viewsize 120\n");
				self.mode = TRUE;
				actor1 = spawn ();
				actor1.owner = self;
				actor1.movetype = MOVETYPE_STEP;
				actor1.solid = SOLID_SLIDEBOX;
				actor1.takedamage = DAMAGE_AIM;
				actor1.classname = "actor1";
				setmodel (actor1, "progs/soldier.mdl");
				setsize(actor1, VEC_HULL_MIN, VEC_HULL_MAX);
				setorigin (actor1, '-1608 264 -528'); // actor's placement
				actor1.health = actor1.max_health = 1;
				actor1.classname = "actor1";
				actor1.think = deadsoldier1_idle1;
				actor1.nextthink = time + 0.1;
				actor1.th_die = deadsoldier1_death;
				self.mode = TRUE;
				thing.owner.goalentity = actor1;
			}
		}
		if (self.mode == TRUE && cutscene == TRUE)
		{
			if (self.cnt == 0)
			{
				if (thing.owner.cam_style != 0)
					thing.owner.cam_style = 0;
				if (thing.owner.test_org_x != -1504)
					thing.owner.test_org_x = -1504;
				if (thing.owner.test_org_y != 304)
					thing.owner.test_org_y = 304;
				if (thing.owner.test_org_z != -496)
					thing.owner.test_org_z = -496;
				setorigin(thing.owner, thing.owner.test_org);
			}
		}
		if (thing.owner.button0 && cutscene == TRUE)
		{
			if (self.cnt == 0)
			{
				thing = find(world, classname, "actor1");
				while (thing != world)
				{
					thing.solid = SOLID_NOT;
					thing.think = deadsoldier1_death;
					thing.nextthink = time + 0.1;
					thing = find(thing, classname, "actor1");
				}
				thing = find(world, classname, "actor2");
				while (thing != world)
				{
					thing.think = SUB_Remove;
					thing.nextthink = time + 0.1;
					thing = find(thing, classname, "actor2");
				}

				thing = find(world, classname, "camera");
				while (thing)
				{
					thing.goalentity = thing.char;
					thing = find(thing, classname, "camera");
				}
				cutscene = FALSE;
			}
		}
		thing = find(thing, classname, "player"); // keep this here!!!
	}
	self.nextthink = time + 0.1;
};




void() cutscenes =
{
	// cutscene specific precaches
	if (self.cnt == 0)
	{
		precache_sound ("speech/deadguy2.wav");
		precache_sound ("speech/deadguy3.wav");
	}

	setmodel(self, string_null);
	self.solid = SOLID_NOT;
	setsize(self, '0 0 0', '0 0 0');
	self.movetype = MOVETYPE_NOCLIP;
	self.think = cutscenes_check;
	self.nextthink = time + 0.1;
};