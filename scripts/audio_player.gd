extends AudioStreamPlayer

const level_music = preload("res://assets/Pixel RPG Music Pack/Pixel Music Pack/Ogg/Pixel 4.ogg")

func _play_music(music: AudioStream, volume = -10.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_music_general():
	_play_music(level_music)

func pause_music():
	if playing:
		stop()
	else:
		play()
