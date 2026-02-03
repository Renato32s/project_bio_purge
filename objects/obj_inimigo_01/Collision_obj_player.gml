/// @description ao colidir com o player

screen_sacode(8); //balança a tela quando morre
fx_sound(sfx_explosion, .4, choose(.5, .8), 0); //chamando o som da explosão
other.perde_vida(); //faz o player perder vida
instance_destroy(); //se drestroi após colidir