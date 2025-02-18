extends Node2D

var rewarded_ad : RewardedAd
var on_user_earned_reward_listener := OnUserEarnedRewardListener.new()
var rewarded_ad_load_callback := RewardedAdLoadCallback.new()
var full_screen_content_callback := FullScreenContentCallback.new()

func _ready():
	$Perdiste.text = str(Global.monedaspartida)
	on_user_earned_reward_listener.on_user_earned_reward = on_user_earned_reward
	
	rewarded_ad_load_callback.on_ad_loaded = on_rewarded_ad_loaded

	full_screen_content_callback.on_ad_clicked = func() -> void:
		print("on_ad_clicked")
	full_screen_content_callback.on_ad_dismissed_full_screen_content = func() -> void:
		print("on_ad_dismissed_full_screen_content")
	full_screen_content_callback.on_ad_failed_to_show_full_screen_content = func(ad_error : AdError) -> void:
		print("on_ad_failed_to_show_full_screen_content")
	full_screen_content_callback.on_ad_impression = func() -> void:
		print("on_ad_impression")
	full_screen_content_callback.on_ad_showed_full_screen_content = func() -> void:
		print("on_ad_showed_full_screen_content")

	RewardedAdLoader.new().load("ca-app-pub-3940256099942544/1712485313", AdRequest.new(), rewarded_ad_load_callback)

func on_rewarded_ad_loaded(rewarded_ad : RewardedAd) -> void:
	print("rewarded ad loaded" + str(rewarded_ad._uid))
	rewarded_ad.full_screen_content_callback = full_screen_content_callback

	var server_side_verification_options := ServerSideVerificationOptions.new()
	server_side_verification_options.custom_data = "TEST PURPOSE"
	server_side_verification_options.user_id = "user_id_test"
	rewarded_ad.set_server_side_verification_options(server_side_verification_options)

	self.rewarded_ad = rewarded_ad

func on_user_earned_reward(rewarded_item : RewardedItem):
	print("on_user_earned_reward, rewarded_item: rewarded", rewarded_item.amount, rewarded_item.type)	
	Global.monedaspartida = Global.monedaspartida * 2
	
func _on_ver_anuncio_pressed():
	
	self.rewarded_ad = rewarded_ad
	rewarded_ad.show(on_user_earned_reward_listener)
	rewarded_ad.destroy()
	$TLoadanuncio.start()
	_on_t_loadanuncio_timeout()
	
func _on_t_loadanuncio_timeout():
	rewarded_ad.destroy()
	on_user_earned_reward_listener.on_user_earned_reward = on_user_earned_reward
	
	rewarded_ad_load_callback.on_ad_loaded = on_rewarded_ad_loaded

	full_screen_content_callback.on_ad_clicked = func() -> void:
		print("on_ad_clicked")
	full_screen_content_callback.on_ad_dismissed_full_screen_content = func() -> void:
		print("on_ad_dismissed_full_screen_content")
	full_screen_content_callback.on_ad_failed_to_show_full_screen_content = func(ad_error : AdError) -> void:
		print("on_ad_failed_to_show_full_screen_content")
	full_screen_content_callback.on_ad_impression = func() -> void:
		print("on_ad_impression")
	full_screen_content_callback.on_ad_showed_full_screen_content = func() -> void:
		print("on_ad_showed_full_screen_content")

	RewardedAdLoader.new().load("ca-app-pub-3940256099942544/5224354917", AdRequest.new(), rewarded_ad_load_callback)


func _on_reinicio_pressed():
	get_tree().paused = false
	Global.monedas += Global.monedaspartida
	Save.saveValue("Menu", "monedas", Global.monedas)
	get_tree().reload_current_scene()

func _on_menu_pressed():
	get_tree().paused = false
	Global.monedas += Global.monedaspartida
	Save.saveValue("Menu", "monedas", Global.monedas)
	get_tree().change_scene_to_file("res://Menu.tscn")


func _on_duplicar_pressed():
	
	self.rewarded_ad = rewarded_ad
	rewarded_ad.show(on_user_earned_reward_listener)
	rewarded_ad.destroy()
	$TLoadanuncio.start()
	_on_t_loadanuncio_timeout()


func _on_refresh_timeout():
	$Perdiste.text = str(Global.monedaspartida)
