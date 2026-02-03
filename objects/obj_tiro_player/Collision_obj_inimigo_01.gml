/// @description ao colidir com o inimigo 01

//tiro se destroi
instance_destroy();
instance_destroy(other);
fx_sound(sfx_explosion, .4, choose(.5, .8), 0); //chamando o som da explosão
screen_sacode(8); //balança a tela quando morre