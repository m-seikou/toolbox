<?php

class dhTest extends PHPUnit_Framework_TestCase
{
	public function test_dh()
	{
		// side A -> send "P" and "G"
		$p = '9999999937';
		$g = '37';

		// side A
		$a = new DH($p, $g);
		$p = $a->getP();
		$g = $a->getG();

		// side B -> rec "P" and "G"  Bのインスタンス化と合わせて公開されているPとGを設定する
		$b = new DH($p, $g);

		// side A -> send G^A mod P
		$value = $a->getPublicValue();
		$b->setPublicValue($value);

		// side B ->send G^B mod P
		$value = $b->getPublicValue();
		$a->setPublicValue($value);

		// 等しい秘密鍵が作られている
		$this->assertEquals($a->getPrivateKey(), $b->getPrivateKey());
		var_dump($a, $b, $a->getPrivateKey());
	}
}
