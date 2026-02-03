/// @description ao colidir com o escudo

screen_sacode(50); //balançando a tela
fx_sound(sfx_explosion, .4, choose(.5, .8), 0); //chamando o som da explosão
instance_destroy(); //inimigo é destruido