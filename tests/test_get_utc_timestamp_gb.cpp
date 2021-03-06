/*
 *  test_get_utc_timestamp_gb.cpp
 *  =============================
 *  Copyright 2013 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Unit tests for test_get_utc_timestamp.cpp using GB timezone.
 *
 *  Requires POSIX extensions.
 *
 *  Uses CppUTest unit testing framework.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#include <CppUTest/CommandLineTestRunner.h>
#include <cstdlib>
#include "../utctime.h"

using namespace utctime;


TEST_GROUP(GetUTCTimestampGBGroup) {
};


/*
 *  Tests get_utc_timestamp() function.
 *
 *  NOTE: March 31, 2013 was chosen for this test as Daylight Saving
 *  Time started on that day in the United Kingdom on that
 *  day.
 */

TEST(GetUTCTimestampGBGroup, GetTimeStamp1Test) {
    const int year = 2013;
    const int month = 3;
    const int day = 31;
    int secs_diff;

    setenv("TZ", "GB", 1);

    for ( int hour = 0; hour < 24; ++hour ) {
        for ( int minute = 0; minute < 60; minute += 15 ) {
            time_t check_timestamp = get_utc_timestamp(year, month, day,
                                                       hour, minute, 0);
            CHECK(check_utc_timestamp(check_timestamp, secs_diff,
                                      year, month, day,
                                      hour, minute, 0));
        }
    }
}

/*
 *  Test the day before, too.
 */

TEST(GetUTCTimestampGBGroup, GetTimeStamp2Test) {
    const int year = 2013;
    const int month = 3;
    const int day = 30;
    int secs_diff;

    setenv("TZ", "GB", 1);

    for ( int hour = 0; hour < 24; ++hour ) {
        for ( int minute = 0; minute < 60; minute += 15 ) {
            time_t check_timestamp = get_utc_timestamp(year, month, day,
                                                       hour, minute, 0);
            CHECK(check_utc_timestamp(check_timestamp, secs_diff,
                                      year, month, day,
                                      hour, minute, 0));
        }
    }
}


/*
 *  Test Sunday, October 27, 2013, DST ends.
 */

TEST(GetUTCTimestampGBGroup, GetTimeStamp3Test) {
    const int year = 2013;
    const int month = 10;
    const int day = 27;
    int secs_diff;

    setenv("TZ", "GB", 1);

    for ( int hour = 0; hour < 24; ++hour ) {
        for ( int minute = 0; minute < 60; minute += 15 ) {
            time_t check_timestamp = get_utc_timestamp(year, month, day,
                                                       hour, minute, 0);
            CHECK(check_utc_timestamp(check_timestamp, secs_diff,
                                      year, month, day,
                                      hour, minute, 0));
        }
    }
}


/*
 *  Test day before, too.
 */

TEST(GetUTCTimestampGBGroup, GetTimeStamp4Test) {
    const int year = 2013;
    const int month = 10;
    const int day = 26;
    int secs_diff;

    setenv("TZ", "GB", 1);

    for ( int hour = 0; hour < 24; ++hour ) {
        for ( int minute = 0; minute < 60; minute += 15 ) {
            time_t check_timestamp = get_utc_timestamp(year, month, day,
                                                       hour, minute, 0);
            CHECK(check_utc_timestamp(check_timestamp, secs_diff,
                                      year, month, day,
                                      hour, minute, 0));
        }
    }
}

