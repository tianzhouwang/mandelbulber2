/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Xenodreambuie
 * @reference
 * http://www.fractalforums.com/3d-fractal-generation/true-3d-mandlebrot-type-fractal/273/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "XenodreambuieIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 XenodreambuieIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL rp = native_powr(aux->r, fractal->bulb.power - 1.0f);
	aux->DE = mad(rp * aux->DE, fractal->bulb.power, 1.0f);
	rp *= aux->r;

	REAL th = atan2(z.y, z.x) + fractal->bulb.betaAngleOffset;
	REAL ph = acos(native_divide(z.z, aux->r)) + fractal->bulb.alphaAngleOffset;

	if (fabs(ph) > 0.5f * M_PI_F) ph = mad(sign(ph), M_PI_F, -ph);

	z.x = rp * native_cos(th * fractal->bulb.power) * native_sin(ph * fractal->bulb.power);
	z.y = rp * native_sin(th * fractal->bulb.power) * native_sin(ph * fractal->bulb.power);
	z.z = rp * native_cos(ph * fractal->bulb.power);
	return z;
}