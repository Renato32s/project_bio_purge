/// @description ao colidir com o escudo

screen_sacode(8); //balança a tela quando morre
fx_sound(sfx_explosion, .4, choose(.5, .8), 0); //chamando o som da explosão
instance_destroy(); //é destruido