/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * iteration weight. Influence fractal based on the weight of
 * Z values after different iterations

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfIterationWeightIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfIterationWeightIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 zA = (aux->i == fractal->transformCommon.intA) ? z : (REAL4){0, 0, 0, 0};
	REAL4 zB = (aux->i == fractal->transformCommon.intB) ? z : (REAL4){0, 0, 0, 0};

	z = (z * fractal->transformCommon.scale) + (zA * fractal->transformCommon.offset)
			+ (zB * fractal->transformCommon.offset0);
	aux->DE *= fractal->transformCommon.scale;
	return z;
}