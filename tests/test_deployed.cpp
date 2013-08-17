/*
 *  test_deployed.cpp
 *  =================
 *  Copyright 2013 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Unit tests for deployed library and header.
 *
 *  Uses CppUTest unit testing framework.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#include <CppUTest/CommandLineTestRunner.h>
#include <paulgrif/utctime.h>


TEST_GROUP(UTCTimeDeployedGroup) {
};


/*
 *  Tests deployed library and header.
 */

TEST(UTCTimeDeployedGroup, LeapYearTest) {
    utctime::UTCTime ut(2013, 8, 17, 9, 39, 0);
}
