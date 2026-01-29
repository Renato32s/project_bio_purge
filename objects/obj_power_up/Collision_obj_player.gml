/// @description colisão com player

//se colidir deve se destruir
instance_destroy(); //se destruindo
particulas(obj_part_power_up, "inst_particulas"); //criando a particula do power_up
other.up_level(); //aumenta o level depois da colisão