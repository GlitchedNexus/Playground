def summarize_jobs(jobs):

    completed_jobs = 0
    total_time = 0
    result = {"total_jobs": len(jobs), "successful_jobs": 0, "failed_jobs": 0}

    for job in jobs:
        status = job.get("status")

        if "success" == status:
            result["successful_jobs"] += 1
            completed_jobs += 1
            total_time += job["duration_sec"]

        if "failed" == status:
            result["failed_jobs"] += 1
            completed_jobs += 1
            total_time += job["duration_sec"]

    if completed_jobs != 0:
        result["average_duration_sec"] = total_time // completed_jobs
    else:
        result["average_duration_sec"] = 0

    return result


print("=== Question 3: average_duration_sec completed jobs ===")

jobs = [
    {"job_id": "a1", "status": "success", "duration_sec": 100},
    {"job_id": "a2", "status": "failed", "duration_sec": 50},
    {"job_id": "a3", "status": "running", "duration_sec": 999},
]

print("Input:", jobs)
print("Output:", summarize_jobs(jobs))
print(
    "Expected:",
    {
        "total_jobs": 3,
        "successful_jobs": 1,
        "failed_jobs": 1,
        "average_duration_sec": 75,
    },
)
print()

jobs = [
    {"job_id": "b1", "status": "running", "duration_sec": 10},
    {"job_id": "b2", "status": "running", "duration_sec": 20},
]

print("Input:", jobs)
print("Output:", summarize_jobs(jobs))
print(
    "Expected:",
    {
        "total_jobs": 2,
        "successful_jobs": 0,
        "failed_jobs": 0,
        "average_duration_sec": 0,
    },
)
print()
