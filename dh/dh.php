<?php

class DH
{
	const BASE = 16;

	const DEFAULT_P = 'ffffffffffffffffffffffffffffff61';

	/**
	 * @var GMP 大きな素数
	 */
	private $P;

	/**
	 * @var GMP 素数
	 */
	private $G;

	/**
	 * @var GMP 秘密の数
	 */
	private $secret;

	/**
	 * @var GMP 公開されている数(受信用)
	 */
	private $publicValue;

	public function __construct(string $P = '', string $G = '')
	{
		if (!empty($P) && !empty($G)) {
			$this->P = gmp_init($P, self::BASE);
			$this->G = gmp_init($G, self::BASE);
		} else {
			$this->P = gmp_init(self::DEFAULT_P, self::BASE);
			$this->G = $this->getRandomPrime();
		}
		$this->secret = $this->getRandomValue();
	}

	/**
	 * P - 2より小さい適当な数
	 * @return GMP
	 */
	private function getRandomValue()
	{
		return gmp_random_range(gmp_init(1), gmp_sub($this->P, gmp_init(2)));
	}

	/**
	 * P - 2 以下のランダムな素数を返す
	 * @return GMP
	 */
	private function getRandomPrime()
	{
		/** @var GMP $prime */
		$prime = gmp_init(4);
		while (!gmp_prob_prime($prime)) {
			$random = $this->getRandomValue();
			$prime = gmp_nextprime($random);
			if (gmp_cmp($this->P, $prime) <= 0) {
				//ランダムに選んだ素数がP - 2を超えているのでやり直す
				continue;
			}
		}
		return $prime;
	}

	/**
	 * 公開用の数を返す
	 * @return string
	 */
	public function getPublicValue()
	{
		return gmp_strval(gmp_powm($this->G, $this->secret, $this->P), self::BASE);
	}


	/**
	 * 算出された鍵を返す
	 * @return string
	 */
	public function getPrivateKey()
	{
		return gmp_strval(gmp_powm($this->publicValue, $this->secret, $this->P), self::BASE);
	}

	/**
	 * 公開されている値を受け取る
	 * @param $publicValue
	 */
	public function setPublicValue($publicValue)
	{
		$this->publicValue = gmp_init($publicValue, self::BASE);
	}

	/**
	 * @return string
	 */
	public function getP()
	{
		return gmp_strval($this->P, self::BASE);
	}

	/**
	 * @return string
	 */
	public function getG()
	{
		return gmp_strval($this->G, self::BASE);
	}
}
