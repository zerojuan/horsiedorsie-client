﻿package com.away3d.core.base
			if (_geometryDirty)
				_geometryDirty = false;
					for each (_vertex in _vertices) {
						if (_vertex._positionDirty) {
							_verts[_vertex._vertIndex] = _vertex.x;
						}
			addEventListener(GeometryEvent.GEOMETRY_UPDATED, listener, false, 0, true);