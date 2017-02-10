/****************************************************************************
 *
 * This file is part of the ViSP software.
 * Copyright (C) 2005 - 2017 by Inria. All rights reserved.
 *
 * This software is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * ("GPL") version 2 as published by the Free Software Foundation.
 * See the file LICENSE.txt at the root directory of this source
 * distribution for additional information about the GNU GPL.
 *
 * For using ViSP with software that can not be combined with the GNU
 * GPL, please contact Inria about acquiring a ViSP Professional
 * Edition License.
 *
 * See http://visp.inria.fr for more information.
 *
 * This software was developed at:
 * Inria Rennes - Bretagne Atlantique
 * Campus Universitaire de Beaulieu
 * 35042 Rennes Cedex
 * France
 *
 * If you have questions regarding the use of this file, please contact
 * Inria at visp@inria.fr
 *
 * This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
 * WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 * Description:
 * Example of template tracking.
 *
 * Authors:
 * Amaury Dame
 * Aurelien Yol
 * Fabien Spindler
 *
 *****************************************************************************/
#ifndef vpTemplateTrackerMIForwardCompositional_hh
#define vpTemplateTrackerMIForwardCompositional_hh

#include <visp3/core/vpConfig.h>

#include <visp3/tt/vpTemplateTracker.h>
#include <visp3/tt/vpTemplateTrackerHeader.h>
#include <visp3/core/vpImageFilter.h>

#include <visp3/tt_mi/vpTemplateTrackerMI.h>
#include <visp3/tt_mi/vpTemplateTrackerMIBSpline.h>

/*!
  \class vpTemplateTrackerMIForwardCompositional
  \ingroup group_tt_mi_tracker
  The algorithm implemented in this class is described in \cite Dame12a and \cite Marchand16a.
*/
class VISP_EXPORT vpTemplateTrackerMIForwardCompositional: public vpTemplateTrackerMI
{
protected:
  bool CompoInitialised;

protected:
  void initCompo();
  void initHessienDesired(const vpImage<unsigned char> &I);
  void trackNoPyr(const vpImage<unsigned char> &I);

public:
  vpTemplateTrackerMIForwardCompositional(vpTemplateTrackerWarp *_warp);
};

#endif
