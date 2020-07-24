#include "helper_functions.h"

#include <QCoreApplication>
#include <QQmlEngine>

void registerHelperFunctions()
{
    qmlRegisterType<HelperFunctions>("Industrial.Indicators", 1, 0, "HelperFunctions");
}

Q_COREAPP_STARTUP_FUNCTION(registerHelperFunctions)

HelperFunctions::HelperFunctions(QObject* parent) : QObject(parent)
{
}

