importPackage(Packages.org.csstudio.opibuilder.scriptUtil);

/*
 * AVOID USING CONSOLE PRINT OUT BECAUSE IT SLOWS THE MACHINE DOWN WHEN
 *                  IMAGE RATE IS > 10 PER SECOND
 */
 
var min = widget.getPropertyValue("minimum");
//ConsoleUtil.writeInfo("Minimum " + min);
var max = widget.getPropertyValue("maximum");
//ConsoleUtil.writeInfo("Maximum " + max);

// manual (1) or automatic (0) control?
var ctrl = PVUtil.getLong(pvs[1]);
//ConsoleUtil.writeInfo("Control is set to " + ctrl);
var statsEn = PVUtil.getLong(pvs[7]);
//ConsoleUtil.writeInfo("Stats plugin enabled " + statsEn);
var statsDo = PVUtil.getLong(pvs[6]);
//ConsoleUtil.writeInfo("Stats calculation " + statsDo);

// Some sane defaults
var dMin = 0;
var dMax = 255;

if (ctrl == 0) {
//	ConsoleUtil.writeInfo("Automatic detection");
	display.getWidget("controlLabel").setPropertyValue("text", "AUTO");

	/* Use values from statistics plugin to get min and max
		Can handle even 100 arrays per second..
	*/
	if ((statsEn == 1) && (statsDo == 1)) {
		dMin = PVUtil.getDouble(pvs[4]);
		dMax = PVUtil.getDouble(pvs[5]);
	}

/*
 
 This is TOO slow!!!! even if GX1050:cam1:AcquireTime is set to 0.100 s
 CSS is not capable of keeping up with new data - CPU > 100% --> unresponsive computer!!!
 
	if (statsDo == 0) {
		dMin = 1000000;
		dMax = 0;

		// get values of array PV and find minimum and maximum values
		var data = PVUtil.getDoubleArray(pvs[0]);
		for (var i = 0; i < data.length; i++) {
			if (data[i] < dMin) {
				dMin = data[i];
				//ConsoleUtil.writeInfo("New detected minimum " + dMin);
			}
			if (data[i] > dMax) {
				dMax = data[i];
				//ConsoleUtil.writeInfo("New detected maximum " + dMax);
			}
		}
	}
*/

} else {
//	ConsoleUtil.writeInfo("Manual input");
	display.getWidget("controlLabel").setPropertyValue("text", "MANUAL");

	// read the input fields for minimum and maximum limits
	dMin = PVUtil.getDouble(pvs[2]);
	dMax = PVUtil.getDouble(pvs[3]);
	//ConsoleUtil.writeInfo("New users minimum " + dMin);
	//ConsoleUtil.writeInfo("New users maximum " + dMax);
}

if (min != dMin) {
	widget.setPropertyValue("minimum", dMin);
}
if (max != dMax) {
	widget.setPropertyValue("maximum", dMax);
}

//ConsoleUtil.writeInfo("Final: minimum " + dMin + ", maximum " + dMax);
display.getWidget("minimumLabel").setPropertyValue("text", dMin);
display.getWidget("maximumLabel").setPropertyValue("text", dMax);
