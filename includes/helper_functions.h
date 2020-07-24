#ifndef HELPER_FUNCTIONS_H
#define HELPER_FUNCTIONS_H

#include "export.h"

#include <QObject>

class INDUSTRIAL_INDICATORS_EXPORT HelperFunctions: public QObject
{
public:
    HelperFunctions(QObject* parent = nullptr);
};

#endif // HELPER_FUNCTIONS_H
