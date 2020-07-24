#ifndef INDUSTRIAL_INDICATORS_EXPORT_H
#define INDUSTRIAL_INDICATORS_EXPORT_H

#ifdef _WIN32
#if defined INDUSTRIAL_INDICATORS_DLL
#define INDUSTRIAL_INDICATORS_EXPORT __declspec(dllexport)
#else
#define INDUSTRIAL_INDICATORS_EXPORT __declspec(dllimport)
#endif
#else
#define INDUSTRIAL_INDICATORS_EXPORT
#endif

#endif
