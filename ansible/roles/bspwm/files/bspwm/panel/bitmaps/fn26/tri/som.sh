#!/bin/bash

# Get the summary for today
summary=$(timew summary :day)

# Extract and process the relevant lines
total_time_by_tag=$(echo "$summary" | awk '
BEGIN {
    FS="[ ,:]+";
    OFS=" ";
}
/^[[:space:]]*tag/ { next }  # Skip header
/^[[:space:]]*[0-9]/ {
    # Example line format: "tag1, tag2 08:00:00 - 12:00:00 4:00:00"
    # We expect columns: tags (split by comma), start time, end time, duration
    
    # Extract tags and duration
    tags = $4;
    hours = $NF-0;
    minutes = $(NF-1);
    sub(/h.*/, "", hours);
    sub(/m.*/, "", minutes);
    time_in_minutes = hours * 60 + minutes;
    
    n = split(tags, tag_list, ",");
    for (i = 1; i <= n; i++) {
        tag = tag_list[i];
        gsub(/^ +| +$/, "", tag);  # Trim leading/trailing spaces
        tag_times[tag] += time_in_minutes;
    }
}
END {
    for (tag in tag_times) {
        printf "%s: %d min\n", tag, tag_times[tag];
    }
}')

echo $total_time_by_tag
