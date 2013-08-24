﻿﻿package com.away3d.core.base
			if (!_visibilityupdated)
				_visibilityupdated = new Object3DEvent(Object3DEvent.VISIBLITY_UPDATED, this);
			if (!hasEventListener(Object3DEvent.POSITION_CHANGED))
				_scenePivotPoint = _sceneTransform.deltaTransformVector(_pivotPoint);
				_sceneTransform.position = _sceneTransform.position.subtract(_scenePivotPoint);
			if (_ownSession && event.object.session.parent)
				event.object.session.parent.removeChildSession(_ownSession);
				_ownSession.renderer = null;
				_ownSession.object3D = null;
				_ownSession.blendMode = _blendMode;
				_ownSession.object3D = this;
			_transformDirty = true;
			translate(Vector3D.Z_AXIS, distance); 
			translate(Vector3D.X_AXIS, distance); 
			translate(Vector3D.Y_AXIS, distance); 
		{
			rotate(Vector3D.X_AXIS, angle);
		{
			rotate(Vector3D.Y_AXIS, angle);
		{
			rotate(Vector3D.Z_AXIS, angle);
			transform.prependRotation(angle, axis);
				_rotationTransform.rawData = _flipY.rawData;
				_rotationTransform.appendRotation(-Math.acos(Vector3D.Z_AXIS.dotProduct(zAxis))*180/Math.PI, Vector3D.Y_AXIS);
			if (Matrix3DUtils.compare(oldTransform, _transform))
			addEventListener(Object3DEvent.VISIBLITY_UPDATED, listener, false, 0, true);
			addEventListener(Object3DEvent.SCALE_CHANGED, listener, false, 0, true);