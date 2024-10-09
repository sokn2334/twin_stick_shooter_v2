extends AudioStreamPlayer2D

var current_music_track: AudioStream

func play_track(new_stream: AudioStream, volume:int = 1.0):
	if (stream == new_stream):
		return
		
	stream = new_stream
	volume_db = volume
	max_distance = 10000
	play()
	
func play_SFX(new_stream: AudioStream, volume:int):
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = new_stream
	sfx_player.volume_db = volume
	sfx_player.name = "SFX_Instance"
	add_child(sfx_player)
	sfx_player.play()
	
	#Anything after will not happen until it hears the signal
	await sfx_player.finished
	sfx_player.queue_free()
