/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * mandelbulb Quaternion
 *

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "MandelbulbQuatIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MandelbulbQuatIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.addCpixelEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC1)
	{
		REAL4 c = aux->const_c;
		REAL4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZC)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZC)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){c.z, c.y, c.x, c.w}; break;
			}
		}
		z += tempC * fractal->transformCommon.constantMultiplierC111;
	}

	// Quaternion fold
	if (aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsD1)
	{
		aux->r = length(z);
		z = (REAL4){z.x * z.x - z.y * z.y - z.z * z.z, z.x * z.y, z.x * z.z, 0.0f};
		aux->DE = aux->DE * 2.0f * aux->r;
		REAL tempL = length(z);
		z *= fractal->transformCommon.constantMultiplier122;
		// if (tempL < 1e-21f) tempL = 1e-21f;
		REAL3 tempAvgScale = (REAL3){z.x, native_divide(z.y, 2.0f), native_divide(z.z, 2.0f)};
		REAL avgScale = native_divide(length(tempAvgScale), tempL);
		REAL tempAux = aux->DE * avgScale;
		aux->DE = mad(fractal->analyticDE.scale1, (tempAux - aux->DE), aux->DE);
		z += fractal->transformCommon.offset000;
		// if (!fractal->analyticDE.enabledFalse)
		//	aux->DE = mad(aux->DE, fabs(aux->actualScale), 1.0f);
		// else
		//	aux->DE =
		//		mad(aux->DE * fabs(aux->actualScale), fractal->analyticDE.scale1,
		//fractal->analyticDE.offset1);
	}
	// sym4
	if (fractal->transformCommon.functionEnabledCxFalse
			&& aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{
		aux->r = length(z);
		aux->DE = aux->DE * 2.0f * aux->r;
		REAL4 temp = z;
		REAL tempL = length(temp);
		// if (tempL < 1e-21f)
		//	tempL = 1e-21f;
		z *= fractal->transformCommon.scale3D111;

		aux->DE *= native_divide(length(z), tempL);

		if (fabs(z.x) < fabs(z.z))
		{
			REAL temp = z.x;
			z.x = z.z;
			z.z = temp;
		}
		if (fabs(z.x) < fabs(z.y))
		{
			REAL temp = z.x;
			z.x = z.y;
			z.y = temp;
		}
		if (fabs(z.y) < fabs(z.z))
		{
			REAL temp = z.y;
			z.y = z.z;
			z.z = temp;
		}

		if (z.x * z.z < 0.0f) z.z = -z.z;
		if (z.x * z.y < 0.0f) z.y = -z.y;

		temp.x = mad(-z.z, z.z, mad(z.x, z.x, -z.y * z.y));
		temp.y = 2.0f * z.x * z.y;
		temp.z = 2.0f * z.x * z.z;

		z = temp + fractal->transformCommon.offsetF000;
		// radial offset
		REAL lengthTempZ = -length(z);
		// if (lengthTempZ > -1e-21f)
		//	lengthTempZ = -1e-21f;   //  z is neg.)
		z *= 1.0f + native_divide(fractal->transformCommon.offset, lengthTempZ);

		// scale
		z *= fractal->transformCommon.scale1;
		aux->DE *= fabs(fractal->transformCommon.scale1);
	}
	// rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	// mandelbulb multi
	if (aux->i >= fractal->transformCommon.startIterationsM
			&& aux->i < fractal->transformCommon.stopIterationsM)
	{
		aux->r = length(z);
		if (fractal->transformCommon.functionEnabledFalse)
		{
			if (fractal->transformCommon.functionEnabledAxFalse
					&& aux->i >= fractal->transformCommon.startIterationsX
					&& aux->i < fractal->transformCommon.stopIterationsX)
				z.x = fabs(z.x);
			if (fractal->transformCommon.functionEnabledAyFalse
					&& aux->i >= fractal->transformCommon.startIterationsY
					&& aux->i < fractal->transformCommon.stopIterationsY)
				z.y = fabs(z.y);
			if (fractal->transformCommon.functionEnabledAzFalse
					&& aux->i >= fractal->transformCommon.startIterationsZ
					&& aux->i < fractal->transformCommon.stopIterationsZ)
				z.z = fabs(z.z);
		}

		REAL th0 = fractal->bulb.betaAngleOffset;
		REAL ph0 = fractal->bulb.alphaAngleOffset;

		REAL3 v;
		switch (fractal->sinTan2Trig.orderOfZYX)
		{
			case multi_OrderOfZYXCl_zyx:
			default: v = (REAL3){z.z, z.y, z.x}; break;
			case multi_OrderOfZYXCl_zxy: v = (REAL3){z.z, z.x, z.y}; break;
			case multi_OrderOfZYXCl_yzx: v = (REAL3){z.y, z.z, z.x}; break;
			case multi_OrderOfZYXCl_yxz: v = (REAL3){z.y, z.x, z.z}; break;
			case multi_OrderOfZYXCl_xzy: v = (REAL3){z.x, z.z, z.y}; break;
			case multi_OrderOfZYXCl_xyz: v = (REAL3){z.x, z.y, z.z}; break;
		}

		if (fractal->sinTan2Trig.asinOrAcos == multi_asinOrAcosCl_asin)
			th0 += asin(native_divide(v.x, aux->r));
		else
			th0 += acos(native_divide(v.x, aux->r));

		if (fractal->sinTan2Trig.atan2OrAtan == multi_atan2OrAtanCl_atan2)
			ph0 += atan2(v.y, v.z);
		else
			ph0 += atan(native_divide(v.y, v.z));

		REAL rp = native_powr(aux->r, fractal->bulb.power - 1.0f);
		REAL th = th0 * fractal->bulb.power * fractal->transformCommon.scaleA1;
		REAL ph = ph0 * fractal->bulb.power * fractal->transformCommon.scaleB1;

		aux->DE = mad(rp * aux->DE, fractal->bulb.power, 1.0f);
		rp *= aux->r;

		if (fractal->transformCommon.functionEnabledxFalse)
		{ // cosine mode
			REAL sinth = th;
			if (fractal->transformCommon.functionEnabledyFalse) sinth = th0;
			sinth = native_sin(sinth);
			z = rp * (REAL4){sinth * native_sin(ph), native_cos(ph) * sinth, native_cos(th), 0.0f};
		}
		else
		{ // sine mode
			REAL costh = th;
			if (fractal->transformCommon.functionEnabledzFalse) costh = th0;
			costh = native_cos(costh);
			z = rp * (REAL4){costh * native_cos(ph), native_sin(ph) * costh, native_sin(th), 0.0f};
		}

		if (fractal->transformCommon.functionEnabledKFalse)
		{
			if (fractal->transformCommon.functionEnabledDFalse)
			{
				REAL temp = z.x;
				z.x = z.y;
				z.y = temp;
			}
			if (fractal->transformCommon.functionEnabledEFalse)
			{
				REAL temp = z.x;
				z.x = z.z;
				z.z = temp;
			}

			// swap
			if (fractal->transformCommon.functionEnabledBxFalse) z.x = -z.x;
			if (fractal->transformCommon.functionEnabledByFalse) z.y = -z.y;
			if (fractal->transformCommon.functionEnabledBzFalse) z.z = -z.z;
		}
	}
	z += fractal->transformCommon.additionConstant000;
	return z;
}