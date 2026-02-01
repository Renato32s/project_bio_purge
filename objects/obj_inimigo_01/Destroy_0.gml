/// @description ao se destruir




particulas(obj_exp_inimigo_01, "inst_particulas"); //crio a particula de explosão

var _chance = random(100); //variável para randomizar quando deve ser criado

if (_chance > 80) //se a chance for maior que 90
{
	particulas(obj_power_up, "inst_level"); //cria o power_up na minha layer
}