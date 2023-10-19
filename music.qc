// FrikaC's player dependant sound code
// so different players hear different music
// cnt is music length, this works by every second only

.float bgm_count;
.float bgm_finished;

void(entity reciever, float vol, float attenuation, float soundnum, vector where, float chan) music =
{
	local float h;

	msg_entity = reciever;
	
	WriteByte(1, 6); // SVC_SOUND
	WriteByte(1, 3); // Mask vol & attenuation
	h = floor (vol * 255);
	WriteByte(1, h);
	WriteByte(1, attenuation * 64);
	WriteShort(1, chan); // world + chan
      WriteByte(1, soundnum);
	WriteCoord(1, where_x);
	WriteCoord(1, where_y);
	WriteCoord(1, where_z);
};

void() MusicPrecache =
{
	// precache music that's used on individual levels to save RAM and keep Dreamcast compatibility
	if (world.model == "maps/ship1.bsp" || world.model == "maps/testroom.bsp")
	{
		precache_sound ("music/cargo.ogg");
		precache_sound ("music/cargo2.ogg");
	}
	if (world.model == "maps/boss1.bsp")
	{
		precache_sound ("music/boss.ogg");
	}
};

void() music_change =
{
	local entity stemp;

	if (other.classname == "player" && other.health > 0)
	{
		if (self.musicstate != other.owner.musicstate)
		{
			other.owner.musicstate = self.musicstate;
			other.owner.bgm_length = time;
			other.owner.bgm_count = self.cnt; // song length, used to repeat in darkplaces
		}
	}
};

void() trigger_music =
{
	InitTrigger ();
	self.touch = music_change;
};