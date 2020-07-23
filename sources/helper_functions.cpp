#include "helper_functions.h"

#include <QCoreApplication>
#include <QQmlEngine>
#include <QDebug>

void registerHelperFunctions()
{
    qDebug() << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
    qmlRegisterType<HelperFunctions>("Industrial.Indicators", 1, 0, "HelperFunctions");
}

Q_COREAPP_STARTUP_FUNCTION(registerHelperFunctions)

HelperFunctions::HelperFunctions(QObject* parent) : QObject(parent)
{
}

