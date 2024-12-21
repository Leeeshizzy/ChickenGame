depth = -999

//move speed stats
movespeed = 1.5
fall_acc = 0.065
move_acc = 0.3

//speedometer_speed = point_distance(xprevious,yprevious,x,y)

//the actual moving stuff 
current_xspeed = 0
xspeed = 0
yspeed = 0


//delaydsdpivmreiogjh
walkdelay = 15



footsteps_time = 0

//states stuff
walljumpcharge = 0
rolltime = 0


//fullscreen lmao
fullscreen = 0

//gun stuff
spread_range[0] = irandom_range(-15,15)
ammo = 3
gun_angle = 0
shootcd = 0
shotgun_sprite = spr_shotgun

airshots = 0
reloadmaxtime = 10

reloadtime = 10
reloading = 0
reloaduimulti = 1

recoilstrength = 7

//extra
flicker = 0

global.hitstop = 0



//health
hp = 100


//stepping sounds
footstep_sound[1] = snd_footstep1
footstep_sound[2] = snd_footstep2
footstep_sound[3] = snd_footstep3
footstep_sound[4] = snd_footstep4

//crawl stuff
crawltimer = 0
crawlspeed = 1


//grappling hook
hookout = false
hookx = 0
hooky = 0
hookstate = "undeployed"
hookxspeed = 0
hookyspeed = 0
retracttime = 0
hooklength = 0
//test stats
mute = 0
test = 0



//game states but like temporary states not like the maion states like an alternate secondary state if you know what im talking about
jump = 0
fired = 0
firetimer = 6
grounded = 0
groundtime = 0
airtime = 0
movetime = 0



//sprite shit replacements
i_xscale = 1



shake = 0

state = playerstate.normal

//weapon states

weapon_equipped = weapon.shotgun


