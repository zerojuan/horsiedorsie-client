﻿package com.away3d.core.filter
			_order = renderer._order;
			_minT = renderer._coeffScreenT/_maxZ;
			for each (i in _order) {
				if (renderer._screenTs[_order[i]] < _minT) {