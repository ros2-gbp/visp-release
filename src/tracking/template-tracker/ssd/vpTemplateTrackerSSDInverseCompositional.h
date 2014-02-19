/****************************************************************************
 *
 * $Id: vpTemplateTrackerSSDInverseCompositional.h 4672 2014-02-17 09:01:17Z fspindle $
 *
 * This file is part of the ViSP software.
 * Copyright (C) 2005 - 2014 by INRIA. All rights reserved.
 *
 * This software is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * ("GPL") version 2 as published by the Free Software Foundation.
 * See the file LICENSE.txt at the root directory of this source
 * distribution for additional information about the GNU GPL.
 *
 * For using ViSP with software that can not be combined with the GNU
 * GPL, please contact INRIA about acquiring a ViSP Professional
 * Edition License.
 *
 * See http://www.irisa.fr/lagadic/visp/visp.html for more information.
 *
 * This software was developed at:
 * INRIA Rennes - Bretagne Atlantique
 * Campus Universitaire de Beaulieu
 * 35042 Rennes Cedex
 * France
 * http://www.irisa.fr/lagadic
 *
 * If you have questions regarding the use of this file, please contact
 * INRIA at visp@inria.fr
 *
 * This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
 * WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 * Description:
 * Template tracker.
 *
 * Authors:
 * Amaury Dame
 * Aurelien Yol
 * Fabien Spindler
 *
 *****************************************************************************/
/*!
 \file vpTemplateTrackerSSDInverseCompositional.h
 \brief
*/
#ifndef vpTemplateTrackerSSDInverseCompositional_hh
#define vpTemplateTrackerSSDInverseCompositional_hh

#include <vector>

#include <visp/vpTemplateTrackerSSD.h>

/*!
 The algorithm implemented in this class is described in \cite Baker04a.
 */
class VISP_EXPORT vpTemplateTrackerSSDInverseCompositional: public vpTemplateTrackerSSD
{
  protected:
    bool      compoInitialised;
    vpMatrix  HInv;
    vpMatrix  HCompInverse;
    bool      useTemplateSelect;//use only the strong gradient pixels to compute the Jabocian
    //pour eval evolRMS
    double    evolRMS;
    std::vector<double> x_pos;
    std::vector<double> y_pos;
    double    threshold_RMS;
    
  protected:
    void  initHessienDesired(const vpImage<unsigned char> &I);
    void  initCompInverse(const vpImage<unsigned char> &I);
    void  trackNoPyr(const vpImage<unsigned char> &I);
    void  deletePosEvalRMS();
    void  computeEvalRMS(const vpColVector &p);
    void  initPosEvalRMS(vpColVector &p);

  public:
          vpTemplateTrackerSSDInverseCompositional(vpTemplateTrackerWarp *warp);

    /*! Use only the strong gradient pixels to compute the Jabobian. By default this feature is disabled. */
    void  setUseTemplateSelect(bool b) {useTemplateSelect = b;}
    void  setThresholdRMS(double threshold){threshold_RMS=threshold;}
};
#endif

